#!/usr/bin/python

import string
import random
import time

charset = string.ascii_uppercase + string.digits + string.ascii_lowercase
hashtags = ["spark", "hadoop", "kafka", "flink", "heron", "sql", "aurora", "storm", "cassandra", "hana", "ibm", "concur", "facebook", "amazon", "microsoft"]

s_nouns = ["A dude", "His mom", "The king", "Some guy", "A cat with rabies", "A sloth", "Your homie", "This cool guy my gardener met yesterday", "Superman"]
p_nouns = ["These dudes", "Both of his moms", "All the kings of the world", "Some guys", "All of a cattery's cats", "The multitude of sloths living under your bed", "Your homies", "Like, these, like, all these people", "Supermen"]
s_verbs = ["eats", "kicks", "gives", "treats", "meets with", "creates", "hacks", "configures", "spies on", "retards", "meows on", "flees from", "tries to automate", "explodes"]
p_verbs = ["eat", "kick", "give", "treat", "meet with", "create", "hack", "configure", "spy on", "retard", "meow on", "flee from", "try to automate", "explode"]
infinitives = ["to make a pie.", "for no apparent reason.", "because the sky is green.", "for a disease.", "to be able to make toast explode.", "to know more about archeology."]

def sing_sen_maker(new_word):
    s_nouns.append(new_word)
    return ' '.join( [random.choice(s_nouns), random.choice(s_verbs), random.choice(s_nouns).lower() or random.choice(p_nouns).lower(), random.choice(infinitives)])


def id_generator(size=6, chars=charset):
    return ''.join(random.choice(chars) for _ in range(size))

if __name__ == "__main__":
    import json
    from kafka import KafkaClient, KeyedProducer
    kafka = KafkaClient('localhost:9092')
    producer = KeyedProducer(kafka)
    tw_id = 0

    for i in range(10000):
        tag = random.choice(hashtags)
        message = sing_sen_maker(tag)
        tw_id = tw_id + 1
        tweet = {
            'id': tw_id,
            'message': message,
            'time': time.ctime()
        }
        msg = json.dumps(tweet)
        producer.send_messages(b'topic1', tag, msg)
        #print "#{0}:{1}".format(tag, message)
        time.sleep(random.randint(1,50)*0.0001)

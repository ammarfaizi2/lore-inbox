Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268504AbTCAFSO>; Sat, 1 Mar 2003 00:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268509AbTCAFSO>; Sat, 1 Mar 2003 00:18:14 -0500
Received: from [204.127.202.63] ([204.127.202.63]:10705 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S268504AbTCAFSK>; Sat, 1 Mar 2003 00:18:10 -0500
Message-ID: <3E60474C.1060304@kegel.com>
Date: Fri, 28 Feb 2003 21:38:20 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel source spellchecker
References: <3E5DB755.20707@kegel.com> <1046330232.15763.97.camel@localhost.localdomain>
In-Reply-To: <1046330232.15763.97.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------020704040208050708030608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020704040208050708030608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Joe Perches wrote:
> On Wed, 2003-02-26 at 22:59, Dan Kegel wrote:
> 
>>Since the main remaining feature before release of the 2.6
>>kernel is fixing all the remaining spelling errors,
>>this patch seems appropriate. 
> 
> 
> Who let the comedian in? :o

At first I was jokeing, but what the heck, I figured I'd run
it.  Here are the mispelled words that occur in five
or more files and that lookd like real misspellings to my eye.
The list contains some words that are ok in British usage;
I don't have a British spellchecker (that I know how to use).

Perhaps some eagr Perl monger can (after removing the British-ok
words!) contribute a spellcorrect-kernel program that takes
in a liste of known misspellings + corrections, and applies
them to the commments in all kernel source files...
- Dan



-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

--------------020704040208050708030608
Content-Type: text/plain;
 name="errors.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="errors.txt"

accomodate
Acknowledgement
acknowledgements
adaptor
adaptors
adddress
additionnal
alignement
allways
analyse
angerous
apropriate
arround
assosciated
assosiated
asyncronous
Auxillary
availible
avaliable
basicly
beeing
borken
boundry
bramaged
cacheable
callin
cancelled
capabilites
childs
choosen
comamnd
comming
commited
comparision
Compatability
compatibilty
compatiblity
completly
concurent
Continous
continous
controler
controllen
coresponding
decrementer
decriptor
defered
defintions
denormalised
denormalized
dependend
desciptor
devide
differenciate
doesnt
DONT
dont't
dugger
emptive
entrancy
entrys
everytime
explicitely
foward
fuction
funtion
guarenteed
handeling
harware
hasnt
havn't
houldn't
hysical
i'm
immediatly
implemantation
implmentation
Incomming
incomming
indice
infomation
Inifity
inital
initalization
Initalize
initalize
inited
initilization
initing
inteface
interrrupt
interrups
Interupt
intervall
intialization
Intialize
intialize
invokation
is'nt
Lenght
managment
mergeable
middelin
modelled
Modularisation
modularisation
Modularised
neccessary
negociated
Neighbour
neighbour
Noone
nuclecu
occured
occurence
occuring
organised
ouput
outputing
overriden
paramter
paramters
Passthrough
passthru
performace
popies
preceeding
promiscous
realise
realised
receving
Recieve
recieve
recieved
recognised
reenable
reentrance
registred
Regsiter
relevent
Reorganisation
reorganised
requeue
reselection
resetted
ressources
scather
serialisation
shouldnt
signalled
signalling
sleepie
specifc
specifed
speficied
sublicense
succesful
successfull
superflous
Synchronisation
synchronisation
there're
threshhold
throught
thru
timming
TORTIOUS
tranceiver
transfering
transmiting
trasfered
truely
tunables
uffer
uglyness
uncachable
unrecognised
useable
usefull
verticies
waranty
watseful
wierd
writeable
writting

--------------020704040208050708030608--


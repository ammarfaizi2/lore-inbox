Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319139AbSIDL3y>; Wed, 4 Sep 2002 07:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319142AbSIDL3x>; Wed, 4 Sep 2002 07:29:53 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:16568 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S319139AbSIDL3u>; Wed, 4 Sep 2002 07:29:50 -0400
Date: Wed, 4 Sep 2002 12:58:15 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: linux-kernel@vger.kernel.org
Subject: I'm collecting linux boot messages. Care to send me some?
Message-ID: <20020904125815.K781@nightmaster.csn.tu-chemnitz.de>
Reply-To: boot-messages@rameria.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Spam-Score: -0.1 (/)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *17mYQP-00025I-00*xJyKLSwkEq6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear mailing list readers,

I collected already some interesting boot messages posted here.

Now I want more ;-)

Care to help? Then read on.

Why boot messages?

   I followed the Linux development since 5 years now (not much,
   but still) and I'm excited about its widespread use and scalability.

   Linux's boot messages where always fascinating to me, because
   booting doesn't happen that often here, they tell me so much
   about my system and give me the good feeling that everything
   happens like it should and my favorite OS is ready to accept
   my commands.

   On other machines they are a simple "proof" that Linux is
   up and running and detected all the guts of the system while
   booting.

What kind of boot messages are you interested in?

   Mostly boot messages from machines with interesting or unusal
   hardware.

   To give you examples:
      - Linux for Palm
      - Linux for other PDAs
      - Linux on Playstation 2
      - Linux on some Wildfire
      - Linux on 4 x 4 NUMA system
      - (RT-)Linux on some robot
      - Linux embedded in a industrial application
      - Linux as network appliance
      - Linux on the reference machine of some arch MAINTAINER

   but also
      - Linux on host with your selfmade hardware controlling
        your experiment or sth. like that

      - Linux inside a virtual machine simulating a soon to come
        processor or machine (IA64 people?)

      - Linux below 1.0 on authentic hardware (I know some guys
        are working on this ;-))
        
      - The boot message of a machine before having an uptime
        longer than 2 years running Linux. (This is considered
        rare, because the boot messages are saved away, but not
        always)
        
      - Linux running in interesting situations. Here it is the
        story/situation that must convince me to include it in
        the collection.

   Not acceptable are:
      - Trade secrets.
      - Military uses of Linux.
      - Criminal uses of Linux.
      
      These can lead me into trouble and might cause the blocking
      of the whole collection by lawyers or governments. This is
      considered counter productive by me.
      
How to submit?

   Just give me the following information:

   1. the actual boot messages
      a) How to obtain them:
         - Do a 'dmesg >/tmp/boot.msg' directly after boot
         - Look whether /var/log/dmesg or /var/log/boot.msg
           or sth. like that matches your actual boot

         - NO syslog mangled messages please! These require me to
           strip that off. This is only acceptable, if you cannot
           reproduce the boot.

      b) How to send them:
         - I would like to have them as attachment.
         - If attaching is not possible, please care to NOT wrap
           lines in these messages and don't replace spaces with
           tabs or other editor games.
           
      c) Timestamp the actual boot. The date is sufficient but
         more is better. Just call 

         date --utc '+%Y-%m-%d %H:%M:%S'

         as soon as possible after boot. (The format is
         necessary, because the world as no widely accepted
         standard on a complete time format).

   2. Additional information
      a) An informal machine description. 
         What is important to know about this machine?
         What patches have to applied in addition to the Linus
         tree? If this is not the Linus tree, where is the kernel
         from?

      b) Operational mode and environment.
         What does this machine and where is it located?

      c) Pictures.
         Please send a URL to a picture, if you can. Don't send
         me pictures per e-mail. But note that you have some and
         roughly what they show. I'll ask you then.

      d) A story. 
         If this machine does sth. that not every machine in this
         world is doing please tell me. History is also relevant
         here.

What about Copyrights?

   The boot messages are written by the Linux authors and are
   just shown to you on boot. They are also reproducible on the
   right hardware. The authors agreed on the GPL or sth. like
   that when they submitted their code to Linus' tree.

   So I consider the full boot messages as text without real
   copyright. I will never ask for any fees to see the boot
   message collection. 
   
   The boot message collection will stay public and people
   disagreeing here in e-mail or by a letter will be removed from
   the collection with the comment "(removed)" or none.

   However: The story and the pictures - 2.c) and 2.d) - provided
   are in fact copyrighted material and the submitter has agreed
   to have me show his material send to me in my collection by
   sending it to me until he send me an e-mail or letter telling
   the opposite.

   EVERY CONTRIBUTOR IS NAMED with whatever personal information
   he gives me about him and doesn't exceed around 300 characters
   (I don't want full CVs there, sorry ;-)). Staying anonymous is
   ok also, but your contact info is still needed for questions.
   
Now let the fun begin ;-)

Thanks for contributing

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130441AbRCGIaG>; Wed, 7 Mar 2001 03:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130442AbRCGI34>; Wed, 7 Mar 2001 03:29:56 -0500
Received: from [213.82.20.2] ([213.82.20.2]:58374 "EHLO romeo.apsystems.it")
	by vger.kernel.org with ESMTP id <S130441AbRCGI3o>;
	Wed, 7 Mar 2001 03:29:44 -0500
Message-ID: <000501c0a6df$7e5e4900$396dc6d4@alex.cybercable.fr>
From: "Alex Baretta" <alex@baretta.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Major system crash 2.2.14 HELP!!!
Date: Wed, 7 Mar 2001 09:20:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I desperately need your help. I booted my machine 15 minutes ago,
pressed return at the LILO prompt to load the default kernel, waited
for the visual login screen to appear, I logged on to my account (not
root), started a terminal and ... and that's as much as I can tell
you. I left the computer for a few minutes to prepare my breakfast,
and when I sat down to my machine with my bowl of cereals in front of
me, I saw a most horrific vision: the LILO prompt once again. The
machine crashed so severely it rebooted directly without showing any
previous signs of agony. And what is worse, the machine now refuses to
start up. It tells me the superblock of some device does not pass file
system check (superblock is damaged). If offers me the possibility of
pressing Ctrl-D to resume the boot process or the possibility to type
my root password and start a shell. Ctrl-D results in the machine
observing that it can do nothing but force a reboot. The root password
takes me into a shell where I see the usual directories, but most of
them are empty. And what's even worse is that my data (home directory)
has been blown to interstellar dust.

I have frequently experienced system crashes on my machine. What would
happen exactly is that the machine would become totally unresponsive.
The mouse pointer would usually disappear, and no key combination
(Ctrl-Alt-Del, Ctrl-Alt-BS, Shit-Alt-Fn) would obtain any result, and
would very simply have to reboot the hard way. The frequence actually
appeared to be very random. Some days I would spend in the excess of
12 hours working at my computer and never rebooting. Other days I
remeber having had to reboot every few minutes. Originally I
attributed this phenomenon to an overheating of the drives [ I have 3
IDE drives which _used_to_ run merrily in my case... 8-(     ] Then  I
moved them to a one bay distance from one another, thereby greatly
reducing the temperature they reached, but this did not solve the
random system crashes.

Now my machine was completely cold after one night's rest. I boot up
correctly once, committed suicide, and all I have got is it's corpse.
What can I do? I could reinstall Linux, but first I have to try to get
my /home directory copied somewhere (to my other HD, for example, the
where I keep the Dark Side of the Force handy, for emergencies ... ).
How can I do this? What information can I _attempt_ to recover by
inspecting the cadaver (logs and the like that help a guru or two
figure out what happened?

Please, help me urgently. I am in such distress!

Alex


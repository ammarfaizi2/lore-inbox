Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131082AbRCGN5x>; Wed, 7 Mar 2001 08:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131081AbRCGN5o>; Wed, 7 Mar 2001 08:57:44 -0500
Received: from [217.56.79.235] ([217.56.79.235]:63237 "EHLO romeo.apsystems.it")
	by vger.kernel.org with ESMTP id <S131080AbRCGN5i>;
	Wed, 7 Mar 2001 08:57:38 -0500
Message-ID: <002001c0a70e$3c296360$396dc6d4@alex.cybercable.fr>
From: "Alex Baretta" <alex@baretta.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: R: Major system crash 2.2.14 HELP!!!
Date: Wed, 7 Mar 2001 14:54:57 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----Messaggio originale-----
Da: Jonathan Brugge <jonathan_brugge@hotmail.com>
A: alex@baretta.com <alex@baretta.com>
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
Data: mercoledì 7 marzo 2001 13.23
Oggetto: Re: Major system crash 2.2.14 HELP!!!


>Ok...I'm not an expert on this, but maybe you can make something of
this.
>
[snip]
>
>Jonathan Brugge
>


Thanks for your help Jon. I only just finished backing up /home and
/root to a few tarchives on the Dark Side of my machine. Yes, you are
right, my directories were on several different partitions. /home was
on /dev/md0, a disk-striping software raid. For some reason that
totally escapes my intellectual powers, /dev/md0 ( containing /home
and god knows what else... I forgot long ago) and /dev/md1 (swap
device) , entirely disappeared from the /dev/ directory. Yet, for a
mystical and transcendental manifestation the Light Side of
Informatics, when I typed "mount /home" all the files that were
contained in that directory reappeared. I quickly mounted the Dark
Side partition and copied them there. Now, all I have to do is verify
the integrity of the backups, raze the Light Side and reinstall it
from from the CD. I'll then have to reinstall and rebuild a few things
(gcc, kernel, x ...) and then hopefully all will be well...

Greetings and thanks to all list members who have patiently born this
thread without flaming me. I greatly appreciated everybody's help and
indulgence.

Alex


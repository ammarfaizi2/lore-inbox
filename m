Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313572AbSD3VVh>; Tue, 30 Apr 2002 17:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315165AbSD3VVg>; Tue, 30 Apr 2002 17:21:36 -0400
Received: from velli.mail.jippii.net ([195.197.172.114]:27591 "HELO
	velli.mail.jippii.net") by vger.kernel.org with SMTP
	id <S313572AbSD3VVg>; Tue, 30 Apr 2002 17:21:36 -0400
Message-ID: <8050080.1020201510415.JavaMail.ground12@jippii.fi>
Date: Wed, 1 May 2002 00:18:30 +0300 (EEST)
From: Eric M <ground12@jippii.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
Mime-Version: 1.0
Content-Type: text/plain; Charset=iso-8859-15; Format=Flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Jippii webmail - http://www.jippiigroup.com/
X-Originating-IP: 213.139.166.70
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have a plextor cd-rw drive which i use via scsi emulation, it is the 
only device on my second ide bus.

often when i rip cds with grip that have scratches, grip completely 
stops responding to input and signals, even -9 wont go through. today i 
tried waiting for over half an hour for it to terminate, got bored and 
quit X. the grip process died after doing that but the kernel's scsi 
layer kept spewing error messages on my console and my machine "lagged" 
on about 10-15 second intervals a few seconds at a time. i waited over 
an hour for it to give up, but it didn't so i had to reboot. kernel 
version i'm using is 2.4.17.
-- 

__
Ota itsellesi luotettava kotimainen email http://www.jippii.fi/
Tutustu samalla netin parhaaseen pelipaikkaan JIPPIIGAMESIIN.


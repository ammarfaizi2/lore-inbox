Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289096AbSBMXO3>; Wed, 13 Feb 2002 18:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289098AbSBMXOT>; Wed, 13 Feb 2002 18:14:19 -0500
Received: from web10403.mail.yahoo.com ([216.136.130.95]:11179 "HELO
	web10403.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289096AbSBMXOG>; Wed, 13 Feb 2002 18:14:06 -0500
Message-ID: <20020213231405.55694.qmail@web10403.mail.yahoo.com>
Date: Thu, 14 Feb 2002 10:14:05 +1100 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: "Re: Kernel 2.2.20 RAM requirements"
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> System halted".

I long time ago post about something wrong with the
optimization in the kernel 2.2.20 but it seems that
nobody got it. It is not the boot loader IMHO; You try
to compile it with i386 cpu Or try to add march=i386
in the kernel make file. 

I got the similar problem with 2.2.20 and I never be
able to boot it under 486 machine if I compile it
under 686 machine althought the 486 box has 32Mb RAM,
Finnally I have to modify the make file use march=i386
and choose cpu 386 type



=====
S.KIEU

http://greetings.yahoo.com.au - Yahoo! Greetings
- Send your Valentines love online.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269349AbRHCIby>; Fri, 3 Aug 2001 04:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269345AbRHCIbp>; Fri, 3 Aug 2001 04:31:45 -0400
Received: from web10401.mail.yahoo.com ([216.136.130.93]:65040 "HELO
	web10401.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269342AbRHCIba>; Fri, 3 Aug 2001 04:31:30 -0400
Message-ID: <20010803083139.40320.qmail@web10401.mail.yahoo.com>
Date: Fri, 3 Aug 2001 18:31:39 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: PROBLEM 2.4.7-ac4 ext3 non recoverable !
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can reproduce this on my machine reliably

After a power off the computer without unmounting the
system (Just my socket is overloaded and the breaker
jumped :-) ) When startup the kernel stop at the
message

EXT3-fs: INFO: recovery required on readonly file
system
EXT3-fs write access will be enable during recovery

then hang 


No disk activity , nothing  

So I have to power off again and this time using 2.4.6
( I also test with 2.4.7 ) ; no problem about recovery
ext3 file system.)

I am pleased to supply or do whatever for  more
information if required

Regards




=====
S.KIEU

_____________________________________________________________________________
http://messenger.yahoo.com.au - Yahoo! Messenger
- Voice chat, mail alerts, stock quotes and favourite news and lots more!

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312983AbSEXXPR>; Fri, 24 May 2002 19:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312991AbSEXXPQ>; Fri, 24 May 2002 19:15:16 -0400
Received: from web10408.mail.yahoo.com ([216.136.130.110]:20485 "HELO
	web10408.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312983AbSEXXPP>; Fri, 24 May 2002 19:15:15 -0400
Message-ID: <20020524231512.80758.qmail@web10408.mail.yahoo.com>
Date: Sat, 25 May 2002 09:15:12 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: RE: PROBLEM: memory corruption with i815 chipset variant
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I think it might be related to the OOPS I reported .
With 2.4.19-preX where X=8  with ac or not, with aa,
what ever... my machine oop after exiting X. See the
trace log some one told me to run memtest but it is
all OK,  the culprit is in drm unlocking page
somewhere, 

 My box is i810 chipset. Now I only can use
2.4.19-pre2 :-)
If I do not use dri , oop did not happen.

Regard,


=====
Steve Kieu

http://briefcase.yahoo.com.au - Yahoo! Briefcase
- Save your important files online for easy access!

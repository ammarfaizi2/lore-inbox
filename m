Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267516AbRGMUqi>; Fri, 13 Jul 2001 16:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267527AbRGMUq3>; Fri, 13 Jul 2001 16:46:29 -0400
Received: from gruel.uchicago.edu ([128.135.39.156]:10255 "EHLO
	gruel.uchicago.edu") by vger.kernel.org with ESMTP
	id <S267516AbRGMUqR>; Fri, 13 Jul 2001 16:46:17 -0400
Date: Fri, 13 Jul 2001 15:43:15 -0500 (CDT)
From: Gary Lyons <lyons@gruel.uchicago.edu>
Reply-To: <lyons@pobox.com>
To: <linux-kernel@vger.kernel.org>
Subject: ioctl bug?
Message-ID: <Pine.LNX.4.33.0107131139450.12456-100000@gruel.uchicago.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I think I have found a bug in the kernel.

starting with 2.4.5ac23 and continuing through both 2.4.6 and
2.v.6-ac2 Whenever I try to do a lsattr or chattr on a directory
I get:

	"Inappropriate ioctl for device While reading flags"

on 2.4.5-ac19 I have no problem.

My computer is a pentium 3 with an asus motherboard, i810E
chipset,and ide drives.  running redhat 7.1 and the hard drive
is WDC WD600AB

I am more then happy to supply any more information if necessary
and

Thanks,

Gary

-- 
Where humor is concerned there are no standards -- no one can say what
is good or bad, although you can be sure that everyone will.
                                -- John Kenneth Galbraith




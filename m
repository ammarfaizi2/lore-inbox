Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSGMPvW>; Sat, 13 Jul 2002 11:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315167AbSGMPvV>; Sat, 13 Jul 2002 11:51:21 -0400
Received: from pD9E23254.dip.t-dialin.net ([217.226.50.84]:53632 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315162AbSGMPvU>; Sat, 13 Jul 2002 11:51:20 -0400
Date: Sat, 13 Jul 2002 09:54:00 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Undefined references to "jiffies" on sparc64
Message-ID: <Pine.LNX.4.44.0207130933190.3331-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using 2.5.25 with 
<URL:ftp://luckynet.dynu.com/pub/linux/2.5.25-ct1/patch-2.5.25-ct1.bz2>, I 
get lots of unsigned references to "jiffies" when compiling on sparc64. Do 
jiffies have to be defined in some special location, apart from 
linux/jiffies.h? I can't  find them on i386, either.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------




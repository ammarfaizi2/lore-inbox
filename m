Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318001AbSGLUGL>; Fri, 12 Jul 2002 16:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318004AbSGLUGK>; Fri, 12 Jul 2002 16:06:10 -0400
Received: from pD9E235D3.dip.t-dialin.net ([217.226.53.211]:25734 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318001AbSGLUGJ>; Fri, 12 Jul 2002 16:06:09 -0400
Date: Fri, 12 Jul 2002 14:08:47 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] New network drivers for 2.5.25
Message-ID: <Pine.LNX.4.44.0207121359360.3421-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A patch including Donald Beckers new network drivers can be found here:
<URL:http://luckynet.dynu.com/~thunder/patches/nicdrivers.bz2>

net/ns820.c:    +++++++++++++++++++++++++++++++++++++++++++
net/natsemi.c:  
++++++++++++++++++----------------------------------------------------------
net/starfire.c: 
+++++++++++++++++++++------------------------------------------
net/sundance.c: +++++----
net/via-rhine.c:        
++++++++++++++++++-----------------------------------
net/tulip/winbond-840.c:        
+++++++++++++++++++-----------------------------
net/Config.in:  +-
net/Config.help:        +-
net/Makefile: +++-

5440 lines inserted, 5290 lines removed.
+: up to 32 lines

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


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbSLSSWa>; Thu, 19 Dec 2002 13:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbSLSSWa>; Thu, 19 Dec 2002 13:22:30 -0500
Received: from mamona.cetuc.puc-rio.br ([139.82.74.4]:32210 "EHLO
	mamona.cetuc.puc-rio.br") by vger.kernel.org with ESMTP
	id <S265894AbSLSSW1>; Thu, 19 Dec 2002 13:22:27 -0500
Subject: Linux kernel multimedia experiments
From: Miguel Freitas <miguel@cetuc.puc-rio.br>
To: xine-dev <xine-devel@lists.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Dec 2002 16:35:50 -0200
Message-Id: <1040322951.19099.29.camel@pitanga.ldhs.cetuc.puc-rio.br>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This is cross post on xine-devel and linux-kernel lists. 

Some xine guys are aware of my experiments comparing multimedia
performance in latest kernels (2.4.x and 2.5.x), so instead of preparing
a lengthy email i've just put a page with it.

At this text i present a dummy multimedia simulator which pretends to be
a video player and measures the number of frames that would be dropped
(and also the mean latency). I used ConTest script to generate the
background loads and take some interesting results.

I hope this will be useful not only to improve xine but also kernel
support in general for any other multimedia player. 

http://cambuca.ldhs.cetuc.puc-rio.br/~miguel/multimedia_sim/

Any comments, flames, etc are apreciated (that is, not the flames :)

l-k people, please cc me, i'm not subscribed.


regards,

Miguel Freitas



Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314565AbSDTGI3>; Sat, 20 Apr 2002 02:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314567AbSDTGI2>; Sat, 20 Apr 2002 02:08:28 -0400
Received: from 24.159.204.122.roc.nc.chartermi.net ([24.159.204.122]:10512
	"EHLO tweedle.cabbey.net") by vger.kernel.org with ESMTP
	id <S314565AbSDTGI2>; Sat, 20 Apr 2002 02:08:28 -0400
Date: Sat, 20 Apr 2002 01:06:54 -0500 (CDT)
From: Chris Abbey <linux@cabbey.net>
X-X-Sender: <cabbey@tweedle.cabbey.net>
To: <linux-kernel@vger.kernel.org>
Subject: PDC20268 TX2 support?
Message-ID: <Pine.LNX.4.33.0204200101190.24652-100000@tweedle.cabbey.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back in February someone else asked about support for Promise's
cards, and Alan mentioned that it would probably merge in around
the 2.4.19 timeframe. I'm curious what level of support folks are
expecting? Just basic IDE, or support for the hardware raid features?
I'm getting a bit sick of rebooting to a back level kernel inorder
to pull data from their raid, and even more sick of the hard locks
that only occur when I have their binary module inserted. (please
avoid the flame wars about how dirty a binary only module is, I'm
well aware of that, but I live in the real world and have a lot of
data one of their controllers. :(  )

-- 
Never make a technical decision based upon the politics of the situation.
Never make a political decision based upon technical issues.
The only place these realms meet is in the mind of the unenlightened.
			-- Geoffrey James, The Zen of Programming


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277294AbRLLQhX>; Wed, 12 Dec 2001 11:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281005AbRLLQhN>; Wed, 12 Dec 2001 11:37:13 -0500
Received: from chiark.greenend.org.uk ([212.22.195.2]:41228 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S277294AbRLLQhC>; Wed, 12 Dec 2001 11:37:02 -0500
Date: Wed, 12 Dec 2001 16:37:01 +0000 (GMT)
From: "Jonathan D. Amery" <jdamery@chiark.greenend.org.uk>
To: linux-kernel@vger.kernel.org
Subject: VT82C686 && APM deadlock bug?
Message-ID: <Pine.LNX.4.21.0112121632440.4294-100000@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I haven't seen this reported anywhere, so apologies if you've heard this
before :).

 in 2.4.9 and 2.4.16 with APM compiled in on my Sony Vaio FX201 laptop
(Via VT82C686 chipset) sometimes when the hardware screensaver comes on
(as a result of APM) the machine deadlocks and has to be powered off and
on again.  (Lots of fscking).

 If you want any more info, please ask :).

-- 
Jonathan Amery.      Now there's a light at the end of the tunnel,
   #####                Someone's lit a campfire in my cave.
  #######__o         The first rays of dawn are breaking through the clouds,
  #######'/             And somehow I know I can be brave.      - Steve Kitson


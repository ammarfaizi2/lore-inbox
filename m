Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130608AbRBVABV>; Wed, 21 Feb 2001 19:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129702AbRBVABL>; Wed, 21 Feb 2001 19:01:11 -0500
Received: from balu.sch.bme.hu ([152.66.224.40]:64415 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S129699AbRBVABF>;
	Wed, 21 Feb 2001 19:01:05 -0500
Date: Thu, 22 Feb 2001 01:00:58 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: sudden console lockups (keyb+mouse)
Message-ID: <Pine.GSO.4.30.0102220053570.8797-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This was about the fifth time when i experienced the following:
all of a sudden, my keyboard and mouse (both together, at exactly the same
time), stop responding, ie i can't type or move the mouse around. As the
keyboard stop responding, i also can't use the Magic-key. All other things
go on, process continue to run, i can see everything, but the only thing i
can do is to press the reset button. (It seems that if had an other
machine i could log in via network and shut it down.) Last time i had this
problem about 10 seconds after starting X, but i also met this whitout X
(while running for example mc).

It might hw related, but i have no idea how could i go for sure (please
don't tell me to try it under win :))

I'm running 2.4.1, the mainboard is an Abit VP6, with PS/2 keyboard and
mouse.

Balazs Pozsar.


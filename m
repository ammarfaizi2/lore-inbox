Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267756AbRGQDQ6>; Mon, 16 Jul 2001 23:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267757AbRGQDQs>; Mon, 16 Jul 2001 23:16:48 -0400
Received: from dsl092-071-145.bos1.dsl.speakeasy.net ([66.92.71.145]:9856 "EHLO
	zippy.openstreet.com") by vger.kernel.org with ESMTP
	id <S267756AbRGQDQj>; Mon, 16 Jul 2001 23:16:39 -0400
Date: Mon, 16 Jul 2001 23:12:32 -0400 (EDT)
From: Paul <paul@openstreet.com>
To: linux-kernel@vger.kernel.org
Subject: es1371: unresolved symbol ac97_probe_codec
Message-ID: <Pine.LNX.4.21.0107162307230.4038-100000@zippy.openstreet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:  In upgrading from 2.2.17 (also had 2.4.0-test5 working) to
2.4.6 I am getting the following error when I try to load the es1371
module:

/lib/modules/2.4.6/kernel/drivers/sound/es1371.o: unresolved symbol 
ac97_probe_codec_R1c61c357

A post in Jan 2001 seemed to indicate this might have something
to do with selecting SMP, which I don't have selected.  Any
idea on what might be causing this problem?  I have
soundcore, sound, and es1371 selected as modules...the first
two load fine.

Please cc any replies to my address, thanks.

--Paul


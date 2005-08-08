Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVHHO7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVHHO7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbVHHO7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:59:34 -0400
Received: from news.cistron.nl ([62.216.30.38]:37091 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S1750925AbVHHO7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:59:33 -0400
From: dth@picard.cistron.nl (Danny ter Haar)
Subject: Re: rc5 seemed to kill a disk that rc4-mm1 likes.  Also some X trouble.
Date: Mon, 8 Aug 2005 14:59:27 +0000 (UTC)
Organization: Cistron
Message-ID: <dd7s0f$ktg$1@news.cistron.nl>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <dd5f2j$fj7$1@news.cistron.nl> <42F7419E.3060905@aitel.hist.no> <dd7ibs$8vm$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1123513167 21424 62.216.30.70 (8 Aug 2005 14:59:27 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@picard.cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I <dth@picard.cistron.nl> wrote:
>rc6 [KNOCK WOOD] seems to work just (so far)

It barfed after 18 hours:

scsi1:0:14:0: Attempting to abort cmd ffff810038f6dd40: 0x2a 0x0 0x3
0x91 0x45 0x10 0x0 0x0 0x1 0x0
scsi1: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State at program address 0x13 Mode 0x11
Card was paused

I will followup on linus's announcement with more details.

Danny


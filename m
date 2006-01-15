Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWAOVTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWAOVTZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 16:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWAOVTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 16:19:25 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:42431 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750894AbWAOVTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 16:19:24 -0500
Date: Sun, 15 Jan 2006 22:18:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Damian Pietras <daper@daper.net>
cc: Peter Osterlund <petero2@telia.com>, Phillip Susi <psusi@cfl.rr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Problems with eject and pktcdvd
In-Reply-To: <20060115210443.GA6096@daper.net>
Message-ID: <Pine.LNX.4.61.0601152216220.9875@yvahk01.tjqt.qr>
References: <20060115123546.GA21609@daper.net> <43CA8C15.8010402@cfl.rr.com>
 <20060115185025.GA15782@daper.net> <43CA9FC7.9000802@cfl.rr.com>
 <m3ek39z09f.fsf@telia.com> <20060115210443.GA6096@daper.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> 	pktsetup 0 /dev/hdc
>> 	mount /dev/pktcdvd/0 /mnt/tmp
>> 	umount /mnt/tmp

A question BTW; I do not seem to need pktcdvd for DVD+RWs,
I can just mount them after mkfs'ing /dev/hdc - what's up with that?



Jan Engelhardt
-- 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbTJ0PkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 10:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbTJ0PkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 10:40:11 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:5630 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S262925AbTJ0PkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 10:40:08 -0500
Date: Mon, 27 Oct 2003 10:38:51 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: David Bryson <david@tsumego.com>
cc: Ananda Bhattacharya <anandab@cabm.rutgers.edu>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Tyan S2466 and 3ware Lockup
In-Reply-To: <20031025173504.GC11472@heliosphan.in.cryptobackpack.org>
Message-ID: <Pine.GSO.4.33.0310271034180.26356-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Oct 2003, David Bryson wrote:
>> I have read Vincent Touquet  about the Tyan motherboard and
>> the 3ware problems that cause a lockup. He believes that
...
>I run at least 12+ machines with a similar configuration(Tyan S2466
>dual athon w/3ware controllers). And I have been testing heavy loads
>with them for over a year and not seen anything related to what you describe.
>But, I do not use NatSemi network cards, mostly Broadcom Gbit
>cards(tg3 driver) and some intel e1000 Gbit cards.  Maybe the problem is
>your network card ?

And maybe his problem is cheap memory.  Use memory Tyan has certified for
use on the motherboard.  Otherwise, learn to live with unpredictable
instability. (As a Tyan user for years, every case of a "flaky motherboard"
has turned out to be memory related.  PCI DMA can stress memory beyond
imagination.)

--Ricky



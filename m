Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271494AbTGQPfG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 11:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271500AbTGQPfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 11:35:06 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:133 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S271494AbTGQPfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 11:35:04 -0400
Date: Thu, 17 Jul 2003 16:58:57 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307171558.h6HFwvju003135@81-2-122-30.bradfords.org.uk>
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: Re: Fix IDE initialization when we don't probe for interrupts.
Cc: alan@lxorguk.ukuu.org.uk, B.Zolnierkiewicz@elka.pw.edu.pl,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another trick is the `IDE doubler' for Amiga (but I guess you can make it work
> on any IDE interface): with a few diodes you can map the second bank of 8 IDE
> registers to a second IDE chain, doubling the number of devices you can
> attach.

Does Linux actually support that, (on any architecture)?

I was just imagining a RAID array on laptops which only have one IDE controller...

John.

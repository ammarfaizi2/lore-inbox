Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265845AbUEZWr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265845AbUEZWr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 18:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265843AbUEZWr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 18:47:29 -0400
Received: from ws3.netA.ort.spb.ru ([195.70.200.211]:57537 "EHLO
	gate-n.ort.spb.ru") by vger.kernel.org with ESMTP id S265845AbUEZWr0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 18:47:26 -0400
Date: Thu, 27 May 2004 02:47:21 +0400 (MSD)
From: Andrew Shirrayev <andrews@gate.ort.spb.ru>
To: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: e100 or e1000 on SMP kernel freeze system (ipx+ncp)
In-Reply-To: <200405262227.18949.roger.larsson@norran.net>
Message-ID: <Pine.LNX.4.33.0405270209350.31415-100000@gate.ort.spb.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score-Gate: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Might be related to subject
>
> "Re: Hard Hang with __alloc_pages: 0-order allocation failed (gfp=0x20/1) -
> Not out of memory"?
Ok, thanks.

My problem very different, but maybe have common source.

My problem can repeat on simple system (some kernel
thread and one bash... 1Gb RAM) and very quiet... :-(

Yes, SMP and e10x required :-)

Infinit loop?

>
> e1000 and SMP...
>
> /RogerL


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTIOTcv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 15:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbTIOTcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 15:32:51 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:33034 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261326AbTIOTcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 15:32:50 -0400
Date: Mon, 15 Sep 2003 21:32:37 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: KConfig help text not shown in 2.6.0-test5
In-Reply-To: <3F64FEB7.6010008@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0309152123220.19512-100000@serv>
References: <3F63197D.2000306@cyberone.com.au> <Pine.LNX.4.44.0309131720270.8124-100000@serv>
 <3F645F0A.1000104@cyberone.com.au> <Pine.LNX.4.44.0309141626540.19512-100000@serv>
 <3F64FEB7.6010008@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 15 Sep 2003, Nick Piggin wrote:

> I got a clean 2.6.0-test5 kernel tree, applied your patch, ran make
> oldconfig menuconfig, entered "processor type and features", move over
> "processor family" and select help. That works fine. Enter "processor
> family" and select help for "Pentium-4" and the same help text comes up.
> I just thought you should see the individual help text for that item.

I didn't mention menuconfig. :)
I got patches to fix this, but I haven't integrated them yet.

bye, Roman


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbTIOTep (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 15:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbTIOTep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 15:34:45 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35599 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261409AbTIOTeo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 15:34:44 -0400
Date: Mon, 15 Sep 2003 15:25:35 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: John Bradford <john@grabjohn.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <200309151934.h8FJYI84002544@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.3.96.1030915152110.20945I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003, John Bradford wrote:

> Yes, you're right, from a stability point of view I was being a bit
> impractical.  Any idea how many developers are actually regularly
> testing code on 386s these days, by the way?

Embedded folks, can you tell us? I believe one of the low power CPUs looks
like a 386 w/o F.P. but with a few 486 instructions. Clarification?

CC list trimmed since this has turned from policy to technical.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


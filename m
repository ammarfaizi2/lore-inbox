Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUF0JQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUF0JQk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 05:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUF0JQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 05:16:40 -0400
Received: from mail009.syd.optusnet.com.au ([211.29.132.64]:14256 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261638AbUF0JQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 05:16:37 -0400
Date: Sun, 27 Jun 2004 19:16:24 +1000 (EST)
From: Con Kolivas <kernel@kolivas.org>
To: Wes Janzen <superchkn@sbcglobal.net>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Pauli Virtanen <pauli.virtanen@hut.fi>
Subject: Re: [PATCH] Staircase scheduler v7.4
In-Reply-To: <40DDD6CC.7000201@sbcglobal.net>
Message-ID: <Pine.LNX.4.58.0406271915440.29181@kolivas.org>
References: <40DC38D0.9070905@kolivas.org> <40DDD6CC.7000201@sbcglobal.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2004, Wes Janzen wrote:

> I don't know what's going on but 2.6.7-mm2 with the staircase v7.4 (with 
> or without staircase7.4-1) takes about 3 hours to get from loading the 
> kernel from grub to the login prompt.  Now I realize my K6-2 400 isn't 
> state of the art...  I don't have this problem running 2.6.7-mm2.
> 
> It just pauses after starting nearly every service for an extended 
> period of time.  It responds to sys-rq keys but just seems to be doing 
> nothing while waiting.

Same problem as the rest I'm sure. I'm looking into it. Thanks for report.

Con

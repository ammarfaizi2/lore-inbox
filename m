Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbTI2FH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 01:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbTI2FH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 01:07:28 -0400
Received: from holomorphy.com ([66.224.33.161]:31393 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262802AbTI2FH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 01:07:28 -0400
Date: Sun, 28 Sep 2003 22:08:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Roger Luethi <rl@hellgate.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] No Swap. Re: [BUG 2.6.90-test5] kernel shits itself with 48mb ram under moderate load
Message-ID: <20030929050817.GO4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>, Roger Luethi <rl@hellgate.ch>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ArQ0.821.23@gated-at.bofh.it> <ArQ0.821.25@gated-at.bofh.it> <ArQ0.821.21@gated-at.bofh.it> <ArZC.8f1.9@gated-at.bofh.it> <3F75EC3B.4030305@softhome.net> <20030927201347.GM4306@holomorphy.com> <20030927202548.GB31080@k3.hellgate.ch> <3F77BCE4.2010601@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F77BCE4.2010601@cyberone.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 03:02:28PM +1000, Nick Piggin wrote:
> This particular problem was fixed nicely by getting the kernel to enable
> swap, so I don't think its that bad of a problem.
> Anyway, I think answers involve sizing data structures more effectively
> on small memory boxes, more VM smarts in overload situations, and
> probably most important for desktop use: light weight and unbloated
> user level environment.

The problem statement was unclear, and my original statement about
solutions accordingly inaccurate.


-- wli

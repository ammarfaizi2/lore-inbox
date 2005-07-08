Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbVGHWHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbVGHWHU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbVGHWHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:07:03 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:12485 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S262829AbVGHWFZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:05:25 -0400
X-ORBL: [63.202.173.158]
Date: Fri, 8 Jul 2005 15:05:21 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050708220521.GA4926@taniwha.stupidest.org>
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050708214908.GA31225@taniwha.stupidest.org> <20050708145953.0b2d8030.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708145953.0b2d8030.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 02:59:53PM -0700, Andrew Morton wrote:

> > On Thu, Jun 23, 2005 at 11:28:47AM -0700, Linux Kernel Mailing List wrote:
>           ^^^^^^

> It's been over two weeks and nobody has complained about anything.

Two weeks isn't that long IMO (I only just noticed myself).

> Because 1000 is too high.

How so?  There have been comparatively few complaints about this since
we switched quite some time ago.

Strictly speaking I agree 1000 might be too high --- but we've had it
for so long now, almost all over 2.5.x (I think?) and all of 2.6.x.

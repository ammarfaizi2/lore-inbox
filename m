Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTKYQeZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 11:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTKYQeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 11:34:25 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28679 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262164AbTKYQeN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 11:34:13 -0500
Date: Tue, 25 Nov 2003 11:23:07 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] generalise scheduling classes
In-Reply-To: <3FC2B487.8080709@cyberone.com.au>
Message-ID: <Pine.LNX.3.96.1031125111256.4037B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003, Nick Piggin wrote:

> 
> 
> bill davidsen wrote:
> 
> >In article <3FC0A0C2.90800@cyberone.com.au>,
> >Nick Piggin  <piggin@cyberone.com.au> wrote:
> >
> >| We still don't have an HT aware scheduler, which is unfortunate because
> >| weird stuff like that looks like it will only become more common in future.
> >
> >The idea is hardly new, in the late 60's GE (still a mainframe vendor at
> >that time) was looking at two execution units on a single memory path.
> >They decided it would have problems with memory bandwidth, what else is
> >new?
> >
> 
> I don't think I said new, but I guess they (SMT, NUMA, CMP) are newish
> for architectures supported by Linux Kernel. OK NUMA has been around for
> a while, but the scheduler apparently doesn't work so well for atypical
> new NUMAs like Opteron.

You didn't say new, I wasn't correcting you, just thought that the
historical perspective might be interesting. I would love to try the new
scheduler, but my test computer is not pleased with Fedora.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


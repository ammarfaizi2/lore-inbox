Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbVAOXms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbVAOXms (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 18:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVAOXms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 18:42:48 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:39632 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S262366AbVAOXmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 18:42:44 -0500
Date: Sun, 16 Jan 2005 00:42:58 +0100
From: Sander <sander@humilis.net>
To: linux-kernel@vger.kernel.org
Subject: Re: NUMA or not on dual Opteron
Message-ID: <20050115234258.GA29376@favonius>
Reply-To: sander@humilis.net
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org> <200501121824.44327.rathamahata@ehouse.ru> <Pine.LNX.4.58.0501120730490.2373@ppc970.osdl.org> <20050113094537.GB2547@favonius> <m1sm552k7a.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1sm552k7a.fsf@muc.de>
X-Uptime: 00:38:22 up 10:07, 24 users,  load average: 1.04, 1.09, 1.06
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote (ao):
> Sander <sander@humilis.net> writes:
> > I was under the impression that NUMA is useful on > 2-way systems
> > only. Is this true, and if not, under what circumstances is NUMA
> > useful on 2-way Opteron systems?
> 
> I don't know who gave you this impression, but it's wrong. Using a
> NUMA aware kernel is an advantage under many workloads on a 2way
> Opteron system. 
>
> > In other words: why should one want NUMA to be enabled or disabled for
> > dual Opteron?
> 
> Because it is faster.

I want to thank all who replied. The answers were similar to the above.
I'll update the impression.

        Kind regards, Sander

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267713AbUJWFtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267713AbUJWFtX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267618AbUJWFlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:41:31 -0400
Received: from main.gmane.org ([80.91.229.2]:25319 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267713AbUJWFkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 01:40:22 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kevin Puetz <puetzk@puetzk.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Date: Sat, 23 Oct 2004 00:40:09 -0500
Message-ID: <clcqrr$u5o$1@sea.gmane.org>
References: <4176E08B.2050706@techsource.com> <41785D8D.5070808@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 12-219-2-179.client.mchsi.com
User-Agent: KNode/0.8.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:

> I'd actually prefer AMD, but the AMD market isn't offfering a solution
> comparable to Intel's integrated video. That means AMD and VIA and the
> like are loosing (some, mine at least :-) money since they don't have a
> graphics solution comparable to Intel, in terms of openness and
> basicness. I believe really only nForce and (to a degree; I hardly see
> it) ATI IGP are available in the AMD motherboard market. If you could
> produce something as good or better as Intel's, you might want to go
> talk to VIA, or AMD directly, and have them license it from you and
> massproduce it into their chipsets.

Well, there are the via k8m800 chipsets. That's (I believe?) a unichrome2
IGP, which should have opensource DRI support via unichrome.sf.net (caveat
- I have a unichrome1 in an epia M1000, not the athlon64 variant). It's no
hot-rod performer, but it's good enough for tuxracer and neverball. I have
no idea how it really compares performance-wise to the intel stuff, but it
does at least have open drivers and reasonable GL acceleration.


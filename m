Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWABSat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWABSat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 13:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWABSat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 13:30:49 -0500
Received: from europa.telenet-ops.be ([195.130.137.75]:33254 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1750928AbWABSas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 13:30:48 -0500
Subject: Re: 2.6.15-rc7: known regressions
From: Ochal Christophe <ochal@kefren.be>
To: Andi Kleen <ak@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200601021838.38310.ak@suse.de>
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>
	 <200601021807.52533.ak@suse.de> <20060102172340.GI17398@stusta.de>
	 <200601021838.38310.ak@suse.de>
Content-Type: text/plain
Date: Mon, 02 Jan 2006 19:30:36 +0100
Message-Id: <1136226637.7602.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-02 at 18:38 +0100, Andi Kleen wrote:
> On Monday 02 January 2006 18:23, Adrian Bunk wrote:
> 
> > Would you veto against a section "known regressions" in the final 2.6.15
> > announcement listing this issue with a link to the Bugzilla bug?
> 
> Yes for this case. The original was likely so fragile that it might
> break only with minor changes in the hardware configuration.
> 
> In general listing known regressions is a good idea though.
> 
> It might be a good idea to give them different priorities though - e.g.
> a broken BIOS with a missing workaround is less priority than
> a pure Linux bug.

I'm currently struggling with a probable case of broken BIOS without
workaround, is there a central repository of known simular problems? Is
there a way to pinpoint such problems to prevent people from tossing
these into bugzilla?


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVFCXGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVFCXGY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 19:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVFCXGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 19:06:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:59102 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261161AbVFCXGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 19:06:10 -0400
Subject: Re: [PATCH] prom_find_machine_type typo breaks pSeries lpar boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       ppc64 dev list <linuxppc64-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>, roland@topspin.com
In-Reply-To: <20050603192525.GC11355@otto>
References: <374360000.1117810369@[10.10.2.4]> <52is0vwd49.fsf@topspin.com>
	 <20050603182725.GB11355@otto> <52vf4vuum5.fsf@topspin.com>
	 <20050603192525.GC11355@otto>
Content-Type: text/plain
Date: Sat, 04 Jun 2005 08:58:20 +1000
Message-Id: <1117839500.31082.188.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-03 at 14:25 -0500, Nathan Lynch wrote:
> Typo in prom_find_machine_type from Ben's recent patch "ppc64: Fix
> result code handling in prom_init" prevents pSeries LPAR systems from
> booting.
> 
> Tested on a pSeries 570 and OpenPower 720 (both Power5 LPAR).

Damn ! I'm certain I tested it on P5 ! I must have forgotten to "quilt
ref" before sending the patch (as I did notice this typo and fixed it
just before sending).

Sorry!

Ben.



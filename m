Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWBMShK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWBMShK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 13:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWBMShJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 13:37:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932404AbWBMShH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 13:37:07 -0500
Date: Mon, 13 Feb 2006 10:33:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie
Subject: Re: 2.6.16-rc3: more regressions
In-Reply-To: <20060213182712.GA32350@redhat.com>
Message-ID: <Pine.LNX.4.64.0602131032240.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
 <20060213170945.GB6137@stusta.de> <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org>
 <20060213174658.GC23048@redhat.com> <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org> <20060213182712.GA32350@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Feb 2006, Dave Jones wrote:
> 
> r300 is unlike the other chips though.
> Adding that ID on its own doesn't make any sense, as the rest of the
> radeon driver won't have a clue how to drive the new hardware.

There were RV350 entries in the drm_pciids file before 2.6.15 as far as I 
can tell..

		Linus

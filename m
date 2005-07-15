Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263312AbVGOSV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbVGOSV0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 14:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbVGOSVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 14:21:25 -0400
Received: from ns1.suse.de ([195.135.220.2]:54432 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S263312AbVGOSUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 14:20:46 -0400
Date: Fri, 15 Jul 2005 20:20:45 +0200
From: Andi Kleen <ak@suse.de>
To: Tom Vier <tmv@comcast.net>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: NUMA support for dual core Opteron
Message-ID: <20050715182044.GG15783@wotan.suse.de>
References: <2ea3fae10507141058c476927@mail.gmail.com> <Pine.LNX.4.58.0507141259170.22630@enigma.lanl.gov> <20050714190929.GL23619@wotan.suse.de> <20050715181521.GC30163@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050715181521.GC30163@zero>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 02:15:21PM -0400, Tom Vier wrote:
> On Thu, Jul 14, 2005 at 09:09:29PM +0200, Andi Kleen wrote:
> > However with 90+W CPUs I would strongly recommend having support
> > for PowerNow! and the old style PST table doesn't support
> > dual core or SMP, so you need ACPI for that anyways.
> 
> Do opterons even support powernow? The proc or sysfs control file never
> shows up on mine and the cpu flags don't list it. Then again, neither does
> my athlon64. They're all in 32bit mode.

New enough ones when the BIOS supports it too: yes. Older ones didn't.

-Andi

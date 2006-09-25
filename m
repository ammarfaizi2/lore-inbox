Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751833AbWIYDCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbWIYDCZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 23:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbWIYDCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 23:02:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64221 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751833AbWIYDCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 23:02:25 -0400
Date: Sun, 24 Sep 2006 23:02:15 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: New Intel feature flags.
Message-ID: <20060925030215.GA15224@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060924011532.GA5804@redhat.com> <200609241050.14760.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609241050.14760.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 10:50:14AM +0200, Andi Kleen wrote:
 > On Sunday 24 September 2006 03:15, Dave Jones wrote:
 > > Add supplemental SSE3 instructions flag, and Direct Cache Access flag.
 > > As described in "Intel Processor idenfication and the CPUID instruction
 > > AP485 Sept 2006"
 > 
 > Added thanks. I also added it for x86-64

I just looked at ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt-current/patches/new-intel-cpuid-flags
Somehow "ssse3" became "ssse2".

	Dave


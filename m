Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWIYDFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWIYDFP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 23:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWIYDFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 23:05:15 -0400
Received: from cantor2.suse.de ([195.135.220.15]:22150 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751345AbWIYDFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 23:05:14 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: New Intel feature flags.
Date: Mon, 25 Sep 2006 05:03:29 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060924011532.GA5804@redhat.com> <200609241050.14760.ak@suse.de> <20060925030215.GA15224@redhat.com>
In-Reply-To: <20060925030215.GA15224@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609250503.29715.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 September 2006 05:02, Dave Jones wrote:
> On Sun, Sep 24, 2006 at 10:50:14AM +0200, Andi Kleen wrote:
>  > On Sunday 24 September 2006 03:15, Dave Jones wrote:
>  > > Add supplemental SSE3 instructions flag, and Direct Cache Access flag.
>  > > As described in "Intel Processor idenfication and the CPUID instruction
>  > > AP485 Sept 2006"
>  > 
>  > Added thanks. I also added it for x86-64
> 
> I just looked at ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt-current/patches/new-intel-cpuid-flags
> Somehow "ssse3" became "ssse2".


Sorry fixed.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbVHSPxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVHSPxe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 11:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVHSPxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 11:53:34 -0400
Received: from mx1.suse.de ([195.135.220.2]:46758 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751186AbVHSPxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 11:53:33 -0400
Date: Fri, 19 Aug 2005 17:53:32 +0200
From: Andi Kleen <ak@suse.de>
To: Peter Buckingham <peter@pantasys.com>
Cc: Andi Kleen <ak@suse.de>, Sean Bruno <sean.bruno@dsl-only.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-git10 test report [x86_64](WITHOUT NVIDIA MODULE)
Message-ID: <20050819155332.GM22993@wotan.suse.de>
References: <1124401950.14825.13.camel@home-lap.suse.lists.linux.kernel> <p73u0hmsy83.fsf@verdi.suse.de> <1124405533.14825.24.camel@home-lap> <20050818230349.GC22993@wotan.suse.de> <1124410753.14825.32.camel@home-lap> <4305FCF1.6020905@pantasys.com> <20050819154639.GL22993@wotan.suse.de> <4306002F.4000000@pantasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4306002F.4000000@pantasys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 08:52:15AM -0700, Peter Buckingham wrote:
> Andi Kleen wrote:
> >At least his original error message can only happen when  CONFIG_GART_IOMMU
> >is disabled.
> >
> >PCI-DMA:  More that 4GB of RAM and no IOMMU                                
> >PCI-DMA:  32bit PCI IO may malfunction.<6>PCI-DMA:  Disabling IOMMU        
> 
> Yeah, I agree. In the later dmesgs, though, it seems to be enabled.

Those don't show any failure.

-Andi

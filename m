Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVAMRkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVAMRkS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVAMRjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:39:18 -0500
Received: from fsmlabs.com ([168.103.115.128]:25817 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261336AbVAMRig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:38:36 -0500
Date: Thu, 13 Jan 2005 10:38:56 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: jarausch@belgacom.net
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
In-Reply-To: <20050113151050.051BEFEC0E@numa-i.igpm.rwth-aachen.de>
Message-ID: <Pine.LNX.4.61.0501131036540.24811@montezuma.fsmlabs.com>
References: <20050113151050.051BEFEC0E@numa-i.igpm.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001 jarausch@belgacom.net wrote:

> yes I know, you don't like modules without full sources available.
> But Nvidia is the leading vendor of video cards and all 2.4.x
> kernels up to 2.4.13-pre5 work nice with this module.
> 
> Running pre6 I get
> (==) NVIDIA(0): Write-combining range (0xf0000000,0x2000000)
> (EE) NVIDIA(0): Failed to allocate LUT context DMA
> (EE) NVIDIA(0):  *** Aborting ***
> 
> 
> This is Nvidia's 1.0-1541 version of its Linux drivers
> 
> Please keep this driver going during the 2.4.x series of the
> kernel if at all possible.

That is quite the request, support both an old 2.4 kernel and a similarly 
geriatric nvidia driver. If you prefer 2.4.13 why not just go back to a 
working 2.4.13-pre?


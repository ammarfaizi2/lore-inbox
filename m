Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVK3VYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVK3VYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 16:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVK3VYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 16:24:23 -0500
Received: from ns1.suse.de ([195.135.220.2]:1757 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750756AbVK3VYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 16:24:22 -0500
To: donald.d.dugger@intel.com (Donald D Dugger)
Cc: linux-kernel@vger.kernel.org, rajesh.shah@intel.com, akpm@osdl.org
Subject: Re: [PATCH] Add VT flag to cpuinfo
References: <20051130211705.220E9E1486@los-vmm.sc.intel.com>
From: Andi Kleen <ak@suse.de>
Date: 30 Nov 2005 18:52:53 -0700
In-Reply-To: <20051130211705.220E9E1486@los-vmm.sc.intel.com>
Message-ID: <p73r78xfuru.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

donald.d.dugger@intel.com (Donald D Dugger) writes:

> Andrew-
> 
> Attached is a trivial patch to 2.6 that will add `vt' to the flags field
> of `/proc/cpuinfo' for CPUs that have Intel's virtualization technology.

The x86-64 tree already has "vmx" for it. What is the correct
name? 

-Andi

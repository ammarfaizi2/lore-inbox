Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbVK3Xlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVK3Xlm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVK3Xlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:41:42 -0500
Received: from cantor.suse.de ([195.135.220.2]:15598 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751239AbVK3Xlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:41:42 -0500
Date: Thu, 1 Dec 2005 00:41:40 +0100
From: Andi Kleen <ak@suse.de>
To: "Dugger, Donald D" <donald.d.dugger@intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       "Shah, Rajesh" <rajesh.shah@intel.com>, akpm@osdl.org
Subject: Re: [PATCH] Add VT flag to cpuinfo
Message-ID: <20051130234140.GW19515@wotan.suse.de>
References: <7F740D512C7C1046AB53446D372001730615830E@scsmsx402.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D372001730615830E@scsmsx402.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 03:34:19PM -0800, Dugger, Donald D wrote:
> Andi-
> 
> Good guess.  We discuessed it and decided that `vmx' was the best
> term so I'll rework the patch to use that name.
> 
> BTW, I don't see any reference to `vmx' in the 2.6.14 tree, is
> this a change you recently made to your tree?

2.6.14 is ancient. Check 2.6.15rc* 
Actually I think I changed 32bit too, so your patch is wholly
obsolete unless you want to rename it.

-Andi


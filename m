Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVK3XuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVK3XuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVK3XuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:50:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:11426 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751257AbVK3XuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:50:23 -0500
Date: Thu, 1 Dec 2005 00:50:19 +0100
From: Andi Kleen <ak@suse.de>
To: "Dugger, Donald D" <donald.d.dugger@intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       "Shah, Rajesh" <rajesh.shah@intel.com>, akpm@osdl.org
Subject: Re: [PATCH] Add VT flag to cpuinfo
Message-ID: <20051130235019.GX19515@wotan.suse.de>
References: <7F740D512C7C1046AB53446D3720017306158375@scsmsx402.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D3720017306158375@scsmsx402.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 03:46:09PM -0800, Dugger, Donald D wrote:
> Andi-
> 
> Story of my life (I've had way too many patches that I
> sent out just a little too late :-)

It might be useful if you could confirm "vmx" is the really
official name that will continue to be used to describe that feature
in the future.  We're already stuck with PNI instead of SSE3 and no
need to make that mistake problem. If VT matches the long term naming better
it would be a good idea to still rename it.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVLAQKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVLAQKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVLAQKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:10:21 -0500
Received: from ozlabs.org ([203.10.76.45]:8350 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932298AbVLAQKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:10:20 -0500
Date: Fri, 2 Dec 2005 03:09:54 +1100
From: Anton Blanchard <anton@samba.org>
To: "Dugger, Donald D" <donald.d.dugger@intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       "Shah, Rajesh" <rajesh.shah@intel.com>, akpm@osdl.org
Subject: Re: [PATCH] Add VT flag to cpuinfo
Message-ID: <20051201160954.GA12616@krispykreme>
References: <7F740D512C7C1046AB53446D372001730615830E@scsmsx402.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D372001730615830E@scsmsx402.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Good guess.  We discuessed it and decided that `vmx' was the best
> term so I'll rework the patch to use that name.
> 
> BTW, I don't see any reference to `vmx' in the 2.6.14 tree, is
> this a change you recently made to your tree?

Unfortunate choice of TLA, VMX is the name for the vector instruction set
on powerpc (otherwise known as altivec).

Anton

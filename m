Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVCKSJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVCKSJW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 13:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVCKSHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 13:07:36 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:43927 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261243AbVCKSFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:05:09 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: AGP bogosities
Date: Fri, 11 Mar 2005 10:04:30 -0800
User-Agent: KMail/1.7.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, werner@sgi.com,
       Linus Torvalds <torvalds@osdl.org>, davej@redhat.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <200503110839.15995.jbarnes@engr.sgi.com> <1110563965.4822.22.camel@eeyore>
In-Reply-To: <1110563965.4822.22.camel@eeyore>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503111004.31311.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 11, 2005 9:59 am, Bjorn Helgaas wrote:
> > Right, it's a special agp driver, sgi-agp.c.
>
> Where's sgi-agp.c?  The HP (ia64-only at the moment) code is hp-agp.c.
> It does make a fake PCI dev for the bridge because DRM still seemed to
> want that.

I think Mike posted it but hasn't submitted it to Dave yet since it needed 
another change that only just made it into the ia64 tree.

Jesse

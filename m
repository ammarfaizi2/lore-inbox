Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVCLDZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVCLDZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 22:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVCLDZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 22:25:54 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40636 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261179AbVCLDZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 22:25:50 -0500
From: Mike Werner <werner@sgi.com>
Reply-To: werner@sgi.com
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: AGP bogosities
Date: Fri, 11 Mar 2005 19:27:04 -0800
User-Agent: KMail/1.6.2
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <1110563965.4822.22.camel@eeyore> <200503111004.31311.jbarnes@engr.sgi.com>
In-Reply-To: <200503111004.31311.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503111927.04807.werner@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 March 2005 10:04, Jesse Barnes wrote:
> On Friday, March 11, 2005 9:59 am, Bjorn Helgaas wrote:
> > > Right, it's a special agp driver, sgi-agp.c.
> >
> > Where's sgi-agp.c?  The HP (ia64-only at the moment) code is hp-agp.c.
> > It does make a fake PCI dev for the bridge because DRM still seemed to
> > want that.
> 
> I think Mike posted it but hasn't submitted it to Dave yet since it needed 
> another change that only just made it into the ia64 tree.
> 
> Jesse
> 
Hi,
sgi-agp.c was sent to Dave about 2 weeks ago. I assumed he was waiting for the TIO header
files to make it from the ia64 tree into Linus's tree.
Yours,
Mike

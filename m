Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267254AbUJIWVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267254AbUJIWVe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 18:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267319AbUJIWVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 18:21:34 -0400
Received: from palrel10.hp.com ([156.153.255.245]:59875 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S267254AbUJIWVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 18:21:31 -0400
Date: Sat, 9 Oct 2004 15:20:11 -0700
From: Grant Grundler <iod00d@hp.com>
To: Colin Ngam <cngam@sgi.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Grant Grundler <iod00d@hp.com>,
       "Luck, Tony" <tony.luck@intel.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Patrick Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
Message-ID: <20041009222011.GA10422@cup.hp.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C989@scsmsx401.amr.corp.intel.com> <41644301.9EC028B3@sgi.com> <20041006195424.GF25773@cup.hp.com> <200410061327.28572.jbarnes@engr.sgi.com> <20041006204832.GB26459@cup.hp.com> <20041006210525.GI16153@parcelfarce.linux.theplanet.co.uk> <41645BDE.E9732310@sgi.com> <4166AF3D.9080808@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4166AF3D.9080808@sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 10:16:13AM -0500, Colin Ngam wrote:
> Now, if we can remove the static from pci_root_ops, I can use it in 
> io_init.c, that would be cleanest and that was what we started with.  


willy already agreed:
http://marc.theaimsgroup.com/?l=linux-ia64&m=109709521721980&w=2

I'm ok with it too.

hth,
grant

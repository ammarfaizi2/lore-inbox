Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVHEWuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVHEWuR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVHEWuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:50:16 -0400
Received: from havoc.gtf.org ([69.61.125.42]:39306 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262017AbVHEWuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:50:08 -0400
Date: Fri, 5 Aug 2005 18:50:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: Kristen Accardi <kristen.c.accardi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       rajesh.shah@intel.com
Subject: Re: [PATCH] 6700/6702PXH quirk
Message-ID: <20050805225005.GA16155@havoc.gtf.org>
References: <1123259263.8917.9.camel@whizzy> <20050805183505.GA32405@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805183505.GA32405@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



AFAICS we don't need a new list, simply consisting of PCI devs.

Just invent, and set, a bit somewhere in struct pci_dev.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTGATHr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTGATHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:07:47 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:39688 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id S263487AbTGATHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:07:46 -0400
Date: Tue, 1 Jul 2003 13:22:09 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Andi Kleen <ak@suse.de>
Cc: James Bottomley <James.Bottomley@steeleye.com>, axboe@suse.de,
       grundler@parisc-linux.org, davem@redhat.com, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode
Message-ID: <20030701192209.GG14683@dsl2.external.hp.com>
References: <1057077975.2135.54.camel@mulgrave> <20030701190938.2332f0a8.ak@suse.de> <1057080529.2003.62.camel@mulgrave> <20030701194241.368a6a9c.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030701194241.368a6a9c.ak@suse.de>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 07:42:41PM +0200, Andi Kleen wrote:
> K8 doesn't have a real IOMMU. Instead it extended the AGP aperture to work
> for PCI devices too.

*gag*...sounds like exactly the opposite HP ZX1 workstations do.
They used part of the SBA IOMMU for AGP GART.

thanks,
grant


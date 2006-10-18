Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423032AbWJRVs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423032AbWJRVs7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423033AbWJRVs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:48:59 -0400
Received: from ns2.suse.de ([195.135.220.15]:18829 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423032AbWJRVs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:48:58 -0400
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: PCI-DMA: Disabling IOMMU
Date: Wed, 18 Oct 2006 23:48:44 +0200
User-Agent: KMail/1.9.3
Cc: Sebastian Biallas <sb@biallas.net>, linux-kernel@vger.kernel.org
References: <45364248.2020901@biallas.net> <20061018211509.GB4582@rhun.haifa.ibm.com>
In-Reply-To: <20061018211509.GB4582@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610182348.44968.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 October 2006 23:15, Muli Ben-Yehuda wrote:
> On Wed, Oct 18, 2006 at 05:03:36PM +0200, Sebastian Biallas wrote:
> 
> > Should I worry about this IOMMU-disabling? All other Linux/IOMMU stuff I
> > found had AGP or BIOS messages nearby, but I only get this single
> > "PCI-DMA: Disabling IOMMU" line, without any hint.
> 
> No, it's fine. Just a badly worded information message. Andi, how
> about something like this?

I think the original message is fine. I'm sure someone will be alarmed
about any possible message, but we can't help them.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWKBAkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWKBAkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWKBAkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:40:11 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:29102 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751397AbWKBAkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:40:08 -0500
Date: Wed, 1 Nov 2006 18:40:05 -0600
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH 2/2]: Use newly defined PCI channel offline routine
Message-ID: <20061102004005.GY6360@austin.ibm.com>
References: <20061101235417.GV6360@austin.ibm.com> <20061102000035.GW6360@austin.ibm.com> <454939BB.3060607@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454939BB.3060607@intel.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 04:20:11PM -0800, Auke Kok wrote:
> why not write this so that it reads:
> 
> > +	if (pci_channel_offline(pdev))

Dohhh! of course!

My excuse? Someone was trying to talk to me 
while I wrote this code ... 

--linas


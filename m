Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbVEMQbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVEMQbL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 12:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVEMQbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 12:31:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:31685 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262383AbVEMQbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 12:31:10 -0400
Date: Fri, 13 May 2005 09:18:55 -0700
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       PPC64-dev <linuxppc64-dev@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] Updated: fix-pci-mmap-on-ppc-and-ppc64.patch
Message-ID: <20050513161855.GC11089@kroah.com>
References: <200505131744.11095.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505131744.11095.michael@ellerman.id.au>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 05:44:10PM +1000, Michael Ellerman wrote:
> Hi Andrew,

Hm, why not send this to the pci maintainer?

> This is an updated version of Ben's fix-pci-mmap-on-ppc-and-ppc64.patch
> which is in 2.6.12-rc4-mm1.
> 
> It fixes the patch to work on PPC iSeries, removes some debug printks
> at Ben's request, and incorporates your 
> fix-pci-mmap-on-ppc-and-ppc64-fix.patch also.

I'll add it to my queue.

greg k-h

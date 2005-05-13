Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVEMH7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVEMH7s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 03:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVEMH7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 03:59:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:30393 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262287AbVEMH7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 03:59:41 -0400
Subject: Re: [PATCH] Updated: fix-pci-mmap-on-ppc-and-ppc64.patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
Cc: Andrew Morton <akpm@osdl.org>, PPC64-dev <linuxppc64-dev@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <200505131744.11095.michael@ellerman.id.au>
References: <200505131744.11095.michael@ellerman.id.au>
Content-Type: text/plain
Date: Fri, 13 May 2005 17:59:06 +1000
Message-Id: <1115971146.5128.16.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 17:44 +1000, Michael Ellerman wrote:
> Hi Andrew,
> 
> This is an updated version of Ben's fix-pci-mmap-on-ppc-and-ppc64.patch
> which is in 2.6.12-rc4-mm1.
> 
> It fixes the patch to work on PPC iSeries, removes some debug printks
> at Ben's request, and incorporates your 
> fix-pci-mmap-on-ppc-and-ppc64-fix.patch also.
> 
> cheers
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>



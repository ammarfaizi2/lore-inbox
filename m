Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbVEMXd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVEMXd0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVEMXbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:31:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:6850 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262646AbVEMXaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:30:19 -0400
Subject: Re: [PATCH] Updated: fix-pci-mmap-on-ppc-and-ppc64.patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, Andrew Morton <akpm@osdl.org>,
       PPC64-dev <linuxppc64-dev@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20050513161855.GC11089@kroah.com>
References: <200505131744.11095.michael@ellerman.id.au>
	 <20050513161855.GC11089@kroah.com>
Content-Type: text/plain
Date: Sat, 14 May 2005 09:29:32 +1000
Message-Id: <1116026972.5128.29.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 09:18 -0700, Greg KH wrote:
> On Fri, May 13, 2005 at 05:44:10PM +1000, Michael Ellerman wrote:
> > Hi Andrew,
> 
> Hm, why not send this to the pci maintainer?

Because I told him to send it to Andrew as it's just an arch bugfix on
top of my patch that is already in mm ;)

> I'll add it to my queue.

Thanks,
Ben.



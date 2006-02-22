Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWBVNT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWBVNT1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 08:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWBVNT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 08:19:27 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:50129 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750991AbWBVNT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 08:19:26 -0500
Date: Wed, 22 Feb 2006 14:19:18 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Dave Hansen <haveblue@us.ibm.com>,
       xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [ PATCH 2.6.16-rc3-xen 3/3] sysfs: export Xen hypervisor	attributes to sysfs
Message-ID: <20060222131918.GC9295@osiris.boeblingen.de.ibm.com>
References: <43FB2642.7020109@us.ibm.com> <1140542130.8693.18.camel@localhost.localdomain> <20060222123250.GB9295@osiris.boeblingen.de.ibm.com> <43FC5B1D.5040901@us.ibm.com> <1140612969.2979.20.camel@laptopd505.fenrus.org> <43FC61C4.30002@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FC61C4.30002@us.ibm.com>
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 08:06:12AM -0500, Mike D. Day wrote:
> Arjan van de Ven wrote:
> >surely those tools already talk to the hypervisor.. so they might as
> >well ask for this information themselves... no need to bloat the kernel
> >for this
> 
> Yes, it is an optional function. The current implementation is a module
> that can be omitted from the configuration, built-in, or loadable.

If it's not needed, why include it at all?

Heiko

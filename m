Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271798AbTGRPbp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269299AbTGRPax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:30:53 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:15249
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S271873AbTGRP2a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 11:28:30 -0400
Date: Fri, 18 Jul 2003 11:43:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Catalin BOIE <util@deuroconsult.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: libata driver update posted
Message-ID: <20030718154322.GB27152@gtf.org>
References: <3F1711C8.6040207@pobox.com> <Pine.LNX.4.53.0307180924020.19703@hosting.rdsbv.ro> <3F17F28C.9050105@pobox.com> <1058542771.13515.1599.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058542771.13515.1599.camel@workshop.saharacpt.lan>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 05:39:32PM +0200, Martin Schlemmer wrote:
> On Fri, 2003-07-18 at 15:13, Jeff Garzik wrote:
> > Catalin BOIE wrote:
> > >>Next update will add several host drivers, now that the libata API is
> > >>settling down.
> > > 
> > > 
> > > Sii3112A is/will be supported?
> > 
> > 
> > Yes, will be.
> > 
> > Silicon Image and Promise support are most likely next.
> > 
> 
> How is performance compared to the default driver for the ICH5 SATA ?

I haven't done any comparisons because the "default driver" just flat
out doesn't work for me.

However, if performance is lower, then I consider that a bug.

	Jeff




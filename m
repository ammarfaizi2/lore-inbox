Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268222AbTGOO1X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 10:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268228AbTGOO1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 10:27:23 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:2233
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S268222AbTGOO1W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 10:27:22 -0400
Date: Tue, 15 Jul 2003 10:42:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Marcelo Penna Guerra <eu@marcelopenna.org>
Cc: Lars Duesing <ld@stud.fh-muenchen.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: include/linux/pci.h inconsistency?
Message-ID: <20030715144212.GB13207@gtf.org>
References: <1058195165.4131.6.camel@ws1.intern.stud.fh-muenchen.de> <200307151027.06474.eu@marcelopenna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307151027.06474.eu@marcelopenna.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 10:27:06AM -0300, Marcelo Penna Guerra wrote:
> Hi Lars,
> 
> On Monday 14 July 2003 12:06, Lars Duesing wrote:
> > btw: this driver_data is used by the networking part of the
> > nforce2-driver. If anybody knows a hint, tell me.
> > Else I will try to wake up someone at nvidia.
> 
> There are patches for nvnet to work with 2.5.x. I'm using it right now with 
> 2.6.0-test1.
> 
> Step by in www.nforcershq.com and join us in the linux forum.


I really would love some person with an nForce NIC to try and use
amd8111e.c or pcnet32.c with their nForce2 NIC, and see what happens.

(you would need to add PCI ids, obviously, and perhaps turn on debugging
to see what happens)

	Jeff




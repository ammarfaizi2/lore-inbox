Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275296AbTHGMbe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 08:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275292AbTHGMbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 08:31:23 -0400
Received: from proibm3.procempa.com.br ([200.248.222.108]:4066 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S275319AbTHGM3z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 08:29:55 -0400
Date: Thu, 7 Aug 2003 09:32:28 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: Alex Williamson <alex_williamson@hp.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <davej@codemonkey.org.uk>,
       <pci-ids@ucw.cz>
Subject: Re: [PATCH] trivial 2.4/2.6 PCI name change/addition
In-Reply-To: <200308061613.26982.bjorn.helgaas@hp.com>
Message-ID: <Pine.LNX.4.44.0308070932010.6582-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Aug 2003, Bjorn Helgaas wrote:

> On Wednesday 06 August 2003 1:54 pm, Alex Williamson wrote:
> >    This patch renames the PCI-X adapter found in HP zx1 and sx1000
> > ia64 systems to something more generic and descriptive.  It also
> > adds an ID for the PCI adapter used in sx1000.  Patches against
> > 2.4.21+ia64 and 2.6.0-test2+ia64 attached.  Thanks,
> 
> I applied this for the 2.4 ia64 patch.
> 
> Marcelo, do we need to do anything else to get this in your tree?


Actually this doesnt apply cleanly to my tree Bjorn.

Can you please send me an updated patch? 


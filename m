Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbUFNPAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUFNPAU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 11:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbUFNPAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 11:00:20 -0400
Received: from mail.dif.dk ([193.138.115.101]:53643 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262850AbUFNPAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 11:00:14 -0400
Date: Mon, 14 Jun 2004 16:59:20 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Ryan Underwood <nemesis-lists@icequake.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       Willy Tarreau <willy@w.ods.org>, twaugh@redhat.com
Subject: Re: Request: Netmos support in parport_serial for 2.4.27
In-Reply-To: <20040614045104.GE27622@dbz.icequake.net>
Message-ID: <Pine.LNX.4.56.0406141655520.7333@jjulnx.backbone.dif.dk>
References: <20040614045104.GE27622@dbz.icequake.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2004, Ryan Underwood wrote:

> On Sun, Jun 13, 2004 at 07:07:27PM -0300, Marcelo Tosatti wrote:
> >
> > Jesper,
> >
> > Two more things.
> >
> > It seems v2.6 also lacks support for this boards:
> >
> > grep PCI_DEVICE_ID_NETMOS_ *
> > pci_ids.h:#define PCI_DEVICE_ID_NETMOS_9735     0x9735
> > pci_ids.h:#define PCI_DEVICE_ID_NETMOS_9835     0x9835
> > [marcelo@localhost linux]$
> >
> > Care to prepare a v2.6 version?
> Seems like someone already did, but I guess it did not get applied for
> some reasons:
> http://seclists.org/lists/linux-kernel/2003/Dec/0654.html

Seems I won't have to try and create a 2.6 version then... I guess I'll
just try and update it to apply cleanly against 2.6.7-rc3 - that is,
unless someone more qualified wants to step in and do it?

--
Jesper Juhl <juhl-lkml@dif.dk>


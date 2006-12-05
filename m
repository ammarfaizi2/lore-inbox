Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967382AbWLEFld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967382AbWLEFld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967528AbWLEFld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:41:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57261 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967382AbWLEFlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:41:32 -0500
Date: Mon, 4 Dec 2006 21:41:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: -mm merge plans for 2.6.20
Message-Id: <20061204214114.433485fc.akpm@osdl.org>
In-Reply-To: <4574FC0A.8090607@garzik.org>
References: <20061204204024.2401148d.akpm@osdl.org>
	<4574FC0A.8090607@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2006 23:56:42 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Andrew Morton wrote:
> > via-pata-controller-xfer-fixes.patch
> > via-pata-controller-xfer-fixes-fix.patch
> 
> Tejun's 3d3cca37559e3ab2b574eda11ed5207ccdb8980a has been ack'd by the 
> reporter as fixing things, so these two shouldn't be needed.

OK thanks, I dropped it.

> 
> > libata_resume_fix.patch
> 
> I thought this was resolved long ago?  Are there still open reports that 
> this solves, where upstream doesn't work?

Heck, I don't know.

> 
> > ahci-ati-sb600-sata-support-for-various-modes.patch
> 
> With the PCI quirk, I thought ATI was finally sorted?

Was it?  I don't know that either.

I'll drop these too.

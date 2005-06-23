Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262830AbVFWXbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbVFWXbq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 19:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVFWXbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 19:31:46 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:35765 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262830AbVFWX3c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 19:29:32 -0400
Subject: Re: SMP+irq handling broken in current git?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200506231258.35258.bjorn.helgaas@hp.com>
References: <20050623135318.GC9768@suse.de> <42BAEA67.7090606@pobox.com>
	 <20050623184234.GE9768@suse.de>  <200506231258.35258.bjorn.helgaas@hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119569195.18655.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Jun 2005 00:26:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-06-23 at 19:58, Bjorn Helgaas wrote:
> Do you have any VIA devices?  If so, you might try the attached.
> (Just for debugging; if the patch helps, I have no idea how to
> do it correctly.)

The VIA routing is documented in the bridge chipset docs. The older ones
are/were on the ftp site. The newer ones are available under NDA or by
asking nicely and having a reason.



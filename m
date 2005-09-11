Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVIJXjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVIJXjG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVIJXjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:39:05 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:20144 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932380AbVIJXjD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:39:03 -0400
Subject: Re: [PATCH] (i)stallion remove
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <432360A2.7040608@gmail.com>
References: <200509101221.j8ACL9XI017246@localhost.localdomain>
	 <43234860.7050206@pobox.com> <43234972.3010003@gmail.com>
	 <20050910211711.GA13660@suse.de> <4323518E.9060407@gmail.com>
	 <432352F0.1080502@pobox.com>  <432360A2.7040608@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 11 Sep 2005 01:03:43 +0100
Message-Id: <1126397023.30449.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-09-11 at 00:39 +0200, Jiri Slaby wrote:
> Jeff Garzik wrote:
> 
> > If the drivers aren't used or maintained, remove them from the kernel 
> > tree.
> 
> So, this as a first:
> 
> (I)stallion remove from the tree, it contains pci_find_device, it is 
> unmaintained and broken for a long time. Noone uses it.

Nak-by: Alan Cox <alan@redhat.com>

Its still on my hitlist - I'm slowly fixing them all


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVIJXkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVIJXkA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVIJXkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:40:00 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:64994 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932381AbVIJXj7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:39:59 -0400
Date: Sat, 10 Sep 2005 17:39:56 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jiri Slaby <jirislaby@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] (i)stallion remove
Message-ID: <20050910233956.GG4770@parisc-linux.org>
References: <200509101221.j8ACL9XI017246@localhost.localdomain> <43234860.7050206@pobox.com> <43234972.3010003@gmail.com> <20050910211711.GA13660@suse.de> <4323518E.9060407@gmail.com> <432352F0.1080502@pobox.com> <432360A2.7040608@gmail.com> <1126397023.30449.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126397023.30449.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 01:03:43AM +0100, Alan Cox wrote:
> On Sul, 2005-09-11 at 00:39 +0200, Jiri Slaby wrote:
> > Jeff Garzik wrote:
> > 
> > > If the drivers aren't used or maintained, remove them from the kernel 
> > > tree.
> > 
> > So, this as a first:
> > 
> > (I)stallion remove from the tree, it contains pci_find_device, it is 
> > unmaintained and broken for a long time. Noone uses it.
> 
> Nak-by: Alan Cox <alan@redhat.com>
> 
> Its still on my hitlist - I'm slowly fixing them all

Are you converting them to the new serial infrastructure at the same
time?

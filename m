Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVILJbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVILJbk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVILJbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:31:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:923 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751260AbVILJbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:31:38 -0400
Date: Mon, 12 Sep 2005 10:31:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Jiri Slaby <jirislaby@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] (i)stallion remove
Message-ID: <20050912093128.GA705@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Peter Chubb <peterc@gelato.unsw.edu.au>,
	Jiri Slaby <jirislaby@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
	Greg KH <gregkh@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-pci@atrey.karlin.mff.cuni.cz,
	Linus Torvalds <torvalds@osdl.org>
References: <200509101221.j8ACL9XI017246@localhost.localdomain> <43234860.7050206@pobox.com> <43234972.3010003@gmail.com> <20050910211711.GA13660@suse.de> <4323518E.9060407@gmail.com> <432352F0.1080502@pobox.com> <432360A2.7040608@gmail.com> <17188.56404.274267.432393@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17188.56404.274267.432393@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 11:39:32AM +1000, Peter Chubb wrote:
> >>>>> "Jiri" == Jiri Slaby <jirislaby@gmail.com> writes:
> 
> Jiri> (I)stallion remove from the tree, it contains pci_find_device,
> Jiri> it is unmaintained and broken for a long time. Noone uses it.
> 
> Arrrg!  We're using it!  It works on UP ia64.  If you want to remove
> it, please send us a supported 8-port serial card :-)

At least we found a tester now.  With this message you just signed up
voluntarily to test a version that brings the driver into the 21st
century ;-)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263820AbUHNQgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbUHNQgV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 12:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUHNQgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 12:36:21 -0400
Received: from the-village.bc.nu ([81.2.110.252]:22491 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263820AbUHNQgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 12:36:20 -0400
Subject: Re: SG_IO and security
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: Jeff Garzik <jgarzik@pobox.com>, Peter Jones <pmjones@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408141008170.9797@kai.makisara.local>
References: <1092313030.21978.34.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org>
	 <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org>
	 <411BA0F4.9060201@pobox.com>
	 <Pine.LNX.4.58.0408120958000.1839@ppc970.osdl.org>
	 <Pine.LNX.4.58.0408122216300.4586@kai.makisara.local>
	 <9ac707cb040813122522d4a71@mail.gmail.com> <411D1885.8060904@pobox.com>
	 <Pine.LNX.4.58.0408141008170.9797@kai.makisara.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092497616.27156.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 14 Aug 2004 16:33:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-08-14 at 08:22, Kai Makisara wrote:
> > Though in general I think command-based filtering is not scalable...  at 
> > the very least I would prefer a list loaded from userspace at boot.
> > 
> I think always requiring CAP_RAWIO would be the approach of least 
> surprise.

Sounds like an excuse for Al to get yet another file system into the
kernel so you can edit filter rules 8)

Alan


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265634AbUAKBGl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 20:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265640AbUAKBGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 20:06:40 -0500
Received: from mail1.kontent.de ([81.88.34.36]:27286 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265634AbUAKBGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 20:06:34 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Subject: Re: [linux-usb-devel] Re: USB hangs
Date: Sun, 11 Jan 2004 02:06:04 +0100
User-Agent: KMail/1.5.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk> <200401110149.34654.oliver@neukum.org> <20040111010143.GF16484@one-eyed-alien.net>
In-Reply-To: <20040111010143.GF16484@one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401110206.04767.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'll agree that it looks dangerous, tho pci_pool_create() is something I
> know little about.
> 
> Is this 2.4 or 2.6 code here?

2.4 / usb-ohci.h

	Regards
		Oliver


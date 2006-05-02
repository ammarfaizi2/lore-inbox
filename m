Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWEBVZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWEBVZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWEBVZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:25:29 -0400
Received: from mail1.kontent.de ([81.88.34.36]:45776 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S964979AbWEBVZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:25:28 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "Ioan Ionita" <opslynx@gmail.com>
Subject: Re: New, yet unsupported USB-Ethernet adaptor
Date: Tue, 2 May 2006 23:25:39 +0200
User-Agent: KMail/1.8
Cc: "Michael Helmling" <supermihi@web.de>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200605022002.15845.supermihi@web.de> <df47b87a0605021340v1c3901e9r17eb3c69034b7487@mail.gmail.com>
In-Reply-To: <df47b87a0605021340v1c3901e9r17eb3c69034b7487@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605022325.39653.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 2. Mai 2006 22:40 schrieb Ioan Ionita:
> > usb 2-10: new high speed USB device using ehci_hcd and address 5
> > usb 2-10: configuration #1 chosen from 1 choice
> >
> > But no eth1 shows up, and module loading and plugging the device seem to be
> > independent. I manually loaded usbnet but it didn't help.
> > Sorry, I really have no experience with kernel or usb development. ;);)
> 
> Me neither. It was a quick & dirty patch, I must have missed
> something. I'll toy around with it some more. Maybe someone more
> experienced could take a look?

You did compile with CONFIG_USB_MOSCHIP, didn't you?

	Regards
		Oliver


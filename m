Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWIJJtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWIJJtf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 05:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWIJJtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 05:49:35 -0400
Received: from buick.jordet.net ([193.91.240.190]:57771 "EHLO buick.jordet.net")
	by vger.kernel.org with ESMTP id S932069AbWIJJte convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 05:49:34 -0400
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
From: Stian Jordet <liste@jordet.net>
To: Greg KH <greg@kroah.com>
Cc: Chris Wedgwood <cw@f00f.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Daniel Drake <dsd@gentoo.org>, akpm@osdl.org, torvalds@osdl.org,
       sergio@sergiomb.no-ip.org, jeff@garzik.org, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru
In-Reply-To: <20060910043741.GA21327@kroah.com>
References: <20060907223313.1770B7B40A0@zog.reactivated.net>
	 <1157811641.6877.5.camel@localhost.localdomain>
	 <4502D35E.8020802@gentoo.org>
	 <1157817836.6877.52.camel@localhost.localdomain>
	 <45033370.8040005@gentoo.org>
	 <1157848272.6877.108.camel@localhost.localdomain>
	 <20060910002112.GA20672@kroah.com>
	 <20060910003922.GA8147@tuatara.stupidest.org>
	 <20060910043741.GA21327@kroah.com>
Content-Type: text/plain; charset=utf-8
Date: Sun, 10 Sep 2006 11:48:49 +0200
Message-Id: <1157881729.4679.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lør, 09,.09.2006 kl. 21.37 -0700, skrev Greg KH:
> Then that sounds like an ACPI issue, instead of trying to create a quirk
> for the pci device itself.
> 
> Why not enable ACPI (which the manufacturer says is the way to go), and
> then work from there?

I've been using acpi on that motherboard since early 2.5, and it works
fine. But I still need that quirk to get it working. 

The acpi guys are well aware of my problem since early 2004, but hasn't
been able to fix it yet, at least. 

http://bugzilla.kernel.org/show_bug.cgi?id=2874

So if you disable the quirk for me, my computer will be without usb and
acpi...

Still, noone would be happier than me if this is solved "the right way".

Thanks.

Best regards,
Stian


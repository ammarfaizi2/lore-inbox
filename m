Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272450AbTHRUF6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272810AbTHRUF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:05:58 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:54695 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S272450AbTHRUF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:05:57 -0400
Subject: RE: 2.6.0-test3 latest bk hangs when enabling IO-APIC
From: Stian Jordet <liste@jordet.nu>
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1061234596.594.3.camel@chevrolet.hybel>
References: <BF1FE1855350A0479097B3A0D2A80EE009FC6D@hdsmsx402.hd.intel.com>
	 <1061234596.594.3.camel@chevrolet.hybel>
Content-Type: text/plain
Message-Id: <1061237161.614.1.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 18 Aug 2003 22:06:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 18.08.2003 kl. 21.23 skrev Stian Jordet:
> man, 18.08.2003 kl. 19.53 skrev Brown, Len: 
> > Try booting with pci=noacpi, and if that doesn't work acpi=off
> > If either of those work, then file in bugzilla with component=ACPI and
> > assign it to len.brown@intel.com
> 
> It works when booting with noapic, but not with acpi=off nor pci=noapic.
> Does that mean I can't blame you for it?

Just to confuse myself (and whoever reading my mails). When I disabled
the second onboard ide-port, the kernel booted, but usb didn't work.
Absolutely no problem what so ever with -test3.

Best regards,
Stian


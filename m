Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTEANKL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 09:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbTEANKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 09:10:11 -0400
Received: from net015s.hetnet.nl ([194.151.104.155]:46348 "EHLO hetnet.nl")
	by vger.kernel.org with ESMTP id S261249AbTEANKK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 09:10:10 -0400
Content-Class: urn:content-classes:message
From: <bas.mevissen@hetnet.nl>
To: "Stuffed Crust" <pizza@shaftnet.org>, "David S. Miller" <davem@redhat.com>
Cc: <bas.mevissen@hetnet.nl>, <linux-kernel@vger.kernel.org>
Subject: RE: Broadcom BCM4306/BCM2050  support
Date: Thu, 1 May 2003 15:22:37 +0200
Message-ID: <7dac01c30fe4$bbfebd60$db6897c2@hetnet.local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft CDO for Windows 2000
Thread-Index: AcMP5Lv+4DLt/XvOEdeNYwBQi2Na5Q==
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (..) And as Alan and myself have been
> talking to upper management entities at various wireless card
> companies we know the real reason has to do with making regulation
> agencies happy.  They do have drivers, and they do want to publish
> them and yes they recognize that this will expose a lot of their
> IP and they accept that.

OK. So at least they are open to it. Maybe they should drop a binary somewhere to get a start. It's not what you want in the long term, but I think good enough for now. Then we should work something out for the frequency settings.

What about the access points? There is nothing dangerous to set, so that information (or drivers and applications) can be given free. Does anyone know more about this?

I tried to get some info from an Edimax AP, but no success (yet). They used a PRISM chipset, but their own microcontroller and stuff for the USB instead of the chip from Intersil. So I guess that that will become difficult.

Regards,

Bas.




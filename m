Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTJKMU5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 08:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbTJKMU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 08:20:56 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:18879 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S263279AbTJKMUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 08:20:55 -0400
Subject: Re: Weird stuff with USB and Bluetooth
From: Stian Jordet <liste@jordet.nu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031011023158.GE19749@kroah.com>
References: <1065744760.1344.2.camel@chevrolet.hybel>
	 <20031011023158.GE19749@kroah.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1065874877.1066.0.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 11 Oct 2003 14:21:18 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lør, 11.10.2003 kl. 04.31 skrev Greg KH:
> On Fri, Oct 10, 2003 at 02:12:40AM +0200, Stian Jordet wrote:
> > Hi,
> > 
> > I get these lines in my dmesg at boot-time:
> > 
> > usb 1-2: device not accepting address 3, error -110
> > hci_usb: probe of 1-2:1.1 failed with error -5
> > hci_usb: probe of 1-2:1.2 failed with error -5
> > usb 1-2: USB disconnect, address 4
> > usb 1-2: device not accepting address 5, error -110
> > hci_usb: probe of 1-2:1.1 failed with error -5
> > hci_usb: probe of 1-2:1.2 failed with error -5
> > 
> > Which often means that the usb-hc can't get an interrupt, I have read.
> > The "problem" is that I have several usb devices (scanner, printer,
> > usbserial, hid) and I get no such error with them, only the Bluetooth.
> > And even weirder, the BT-dongle works just perfect.
> > 
> > So my question is; what does this messages means?
> 
> You have a broken device, sorry.

Stupid 3com. But thanks :-) Since the device (at least for now) works
perfectly, I will just shut up :-)

Best regards,
Stian


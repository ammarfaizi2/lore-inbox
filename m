Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVFTQRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVFTQRz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVFTQRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:17:55 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:58034
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261378AbVFTQQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:16:20 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Vojtech Pavlik'" <vojtech@suse.cz>
Cc: <linux-kernel@vger.kernel.org>, <linux-thinkpad@linux-thinkpad.org>
Subject: RE: IBM HDAPS Someone interested?
Date: Mon, 20 Jun 2005 10:16:09 -0600
Message-ID: <005401c575b3$5f5bba90$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20050620155720.GA22535@ucw.cz>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I'm looking for someone, a hope, anything from anyone that
> have an IBM T40,
> > T41, T42 or whoever has the Embedded "Airbag" solution in
> their Linux
> > Laptops.
> >
> > The Hard Drive Active Protection System, which is in the
> IBM laptops (and
> > maybe some others) uses an Analog ADXL320 (or ADXL202) with the
> > accelerometer for XY to monitor the movement in the laptops.
>
> I already have the documentation for the chips for my
> robotics projects,
> I even have the chips. I'll have an Airbag-equipped IBM notebook soon,
> hopefully, too.
>
> However, this is not enough at all to write the driver. The
> accelerometer is a trivial analog component (ok, not so trivial, but
> still just analog), and the main question is how it is
> connected to the
> PC.
>
> Until IBM says something about that, or somebody reverse
> engineers their
> BIOS/Windows drivers/whatever, a driver can't be written.
>
> --
> Vojtech Pavlik
> SuSE Labs, SuSE CR

I was told, that the only thing that was needed was an ADD card. ( Analog to
Digital?)

If you are interested, I can call you and then conference Analog Devices,
and they will tell you what is needed, I bet IBM did whatever Analog Devices
told them to do. And they might even tell us what to do if they talk with
someone that knows (I was bumbling, while he was talking about all the IO
and G rates)

I don't think they have anything in the BIOS related to the HDAPS, else they
would have put something in it. (You can't even disable the chip in the
BIOS) I just think is the accelerometer, there, by itself with an extra card
they added.

.Alejandro


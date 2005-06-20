Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVFTQyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVFTQyO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVFTQyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:54:14 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:64449
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261297AbVFTQxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:53:47 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Vojtech Pavlik'" <vojtech@suse.cz>
Cc: <linux-kernel@vger.kernel.org>, <linux-thinkpad@linux-thinkpad.org>
Subject: RE: IBM HDAPS Someone interested?
Date: Mon, 20 Jun 2005 10:53:35 -0600
Message-ID: <005701c575b8$99c2f450$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20050620163456.GA24111@ucw.cz>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, Jun 20, 2005 at 10:16:09AM -0600, Alejandro Bonilla wrote:
>
> > I was told, that the only thing that was needed was an ADD
> card. ( Analog to
> > Digital?)
>
> Indeed, but there is a zillion of different approaches to an A/D.
> I'm quite sure IBM have rolled their own directly on the mainboard.
>
> The main question is on which bus and which address it lives
> and what is
> the programming interface. It's not something Analog Devices
> would know.
>
> It can be on some monitoring chip living on the SMBus (most likely) or
> coupled directly to the ACPI bridge on PCI, or anywhere else in the
> system.
>
> > If you are interested, I can call you and then conference
> Analog Devices,
> > and they will tell you what is needed, I bet IBM did
> whatever Analog Devices
> > told them to do. And they might even tell us what to do if
> they talk with
> > someone that knows (I was bumbling, while he was talking
> about all the IO
> > and G rates)
>
> Well, I will not be interested until I'm convinced they'll be able to
> tell me something I don't know already.

I bet they will. They don't document it all, and I'm pretty sure that if you
ask the right question, then they will tell you what you are looking for.
After all, they should be our first step before trying anything.

I it obvious to me that they have at least tried once, to play with the IBM
mechanism.

They could have an aswer for us right now and tell us things that could make
things really easy.

After all, you won't pay for the phone call. ;-)

.Alejandro

>
> > I don't think they have anything in the BIOS related to the
> HDAPS, else they
> > would have put something in it. (You can't even disable the
> chip in the
> > BIOS) I just think is the accelerometer, there, by itself
> with an extra card
> > they added.
>
> Well, some piece of software needs to park the HDD when the
> notebook is
> falling, and that piece of software should better be running since the
> notebook is powered on. Hence my suspicion it's in the BIOS.
> It doesn't
> have to be visible to the user, at all.
>
> --
> Vojtech Pavlik
> SuSE Labs, SuSE CR


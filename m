Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbTFVDr0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 23:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbTFVDrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 23:47:25 -0400
Received: from fmr06.intel.com ([134.134.136.7]:979 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265265AbTFVDrK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 23:47:10 -0400
Subject: RE: AIC7(censored) card gone wild?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Sat, 21 Jun 2003 21:01:08 -0700
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE03E6A0@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: AIC7(censored) card gone wild?
Thread-Index: AcM32lz8pVe1iX/0RR+AZ378yvNwUgAmCimA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Matthias Andree" <matthias.andree@gmx.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Jun 2003 04:01:08.0827 (UTC) FILETIME=[E9500AB0:01C33872]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Matthias Andree [mailto:matthias.andree@gmx.de]
> On Fri, 20 Jun 2003, Perez-Gonzalez, Inaky wrote:
> 
> > So I wonder, what does that error mean? SCSI1 has attached a
> > CDRW (Sony Yamaha CDRW 8/4/24) but now it doesn't show up
> > anymore (and so, I cannot get the model). .
> 
> The first step towards finding that out is power cycling (shut down,
> switch off for a minute, then start up again) or physically
> disconnecting the Yamaha drive (if it's Yamaha).

And clean up and check all of the fans, cables, connections,
connect, disconnect ... nothing changes. Something is hosed
up. The three years w/o downtime are biting back now.

> I've seen Adaptecs fuss and fight with Yamahas more than once --
> although in Linux 2.2 and early 2.4 times -- and Yamahas have the nasty
> habit of locking up until the next power cycle when something goes
> wrong.

Yummy ... wonder if it happens the same with their motorbikes.

> > Could it mean by SCSI Adapter is hosed? or my CDRW drive?
> 
> It might be either, I'd suspect the CDRW first unless I had information
> that suggests otherwise.

The panics don't go away, so I am afraid I have something getting
to warm in there, on top of the CD burner being burned. God I 
hate this things happening ...

Thanks,

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)

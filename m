Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318941AbSHMF1e>; Tue, 13 Aug 2002 01:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318942AbSHMF1d>; Tue, 13 Aug 2002 01:27:33 -0400
Received: from WARSL402PIP7.highway.telekom.at ([195.3.96.94]:41528 "HELO
	email02.aon.at") by vger.kernel.org with SMTP id <S318941AbSHMF1c>;
	Tue, 13 Aug 2002 01:27:32 -0400
Message-ID: <001701c2428a$ff625670$8c00000a@sledgehammer>
From: "Peter Klotz" <peter.klotz@aon.at>
To: "Adrian Bunk" <bunk@fs.tum.de>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.NEB.4.44.0208122250590.14606-100000@mimas.fachschaften.tu-muenchen.de>
Subject: Re: 2.4.19 and 2.4.20-pre1 don't boot
Date: Tue, 13 Aug 2002 07:33:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The system configuration is as follows:
> > Athlon XP 1600+
> > Asus A7V266-E (VIA KT266A)
> > 512MB RAM
> > hda, hdc are IDE Harddisks

> what type of IDE controller is in this machine?

The machine has 2 IDE controllers, the standard onboard controller of the
VIA chipset and an onboard Promise IDE Chip which can be switched to RAID0/1
mode. I use the Promise controller in standard IDE mode.
A DVD-ROM and a CD-Writer are connected to the Promise chip as hde and hdg.

> Is there any other error message above the startup message you quoted?

No, there are no other error messages prior to the extracted one.

Best regards, Peter.


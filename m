Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266865AbSLKATw>; Tue, 10 Dec 2002 19:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266868AbSLKATw>; Tue, 10 Dec 2002 19:19:52 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:520 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S266865AbSLKATv>; Tue, 10 Dec 2002 19:19:51 -0500
X-Envelope-From: roubm9am@barbora.ms.mff.cuni.cz
Message-ID: <039d01c2a0ab$b19a5ad0$551b71c3@krlis>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Petr Sebor" <petr@scssoft.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <068d01c29d97$f8b92160$551b71c3@krlis><1039312135.27904.11.camel@irongate.swansea.linux.org.uk><20021208234102.GA8293@scssoft.com>  <021401c2a05d$f1c72c80$551b71c3@krlis> <1039540202.14251.43.camel@irongate.swansea.linux.org.uk>
Subject: Re: IDE feature request & problem
Date: Wed, 11 Dec 2002 01:24:29 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,
I have got xfs partition and man fsck.xfs say
that it will run automatically on reboot.
I don't know where to find any results of the
test, because in syslog is only
SGI XFS with ACLs, DMAPI, realtime, quota, no debug enabled
XFS mounting filesystem md(9,0)
    Thanx for help
    Milan
----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
Cc: "Petr Sebor" <petr@scssoft.com>; "Linux Kernel Mailing List"
<linux-kernel@vger.kernel.org>
Sent: Tuesday, December 10, 2002 6:10 PM
Subject: Re: IDE feature request & problem


> On Tue, 2002-12-10 at 15:07, Milan Roubal wrote:
> > DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound
> > AddrMarkNotFound }, LBAsect=8830595334015, high=526344, low=8355711,
> > sector=196817664
>
> Can you force an fsck of the volume firstly. AddrMark not found isnt too
> nreasonable a compliant given the LBAsect in question
>


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287518AbSAEFUi>; Sat, 5 Jan 2002 00:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287519AbSAEFU2>; Sat, 5 Jan 2002 00:20:28 -0500
Received: from PHNX1-UBR2-4-hfc-0251-d1dae065.rdc1.az.coxatwork.com ([209.218.224.101]:48264
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S287518AbSAEFUM>; Sat, 5 Jan 2002 00:20:12 -0500
Message-ID: <00c601c195a8$bb5c7e90$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "bert hubert" <ahu@ds9a.nl>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <005001c194d9$b5793c40$6caaa8c0@kevin> <20020105000001.A26152@outpost.ds9a.nl>
Subject: Re: How to debug very strange packet delivery problem?
Date: Fri, 4 Jan 2002 22:20:47 -0700
Organization: LSG, Inc.
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

I haven't tried an _older_ kernel yet, but did have the same problem on
2.4.17 and 2.4.17-rc1. I'll try something older tomorrow and see what
happens.

----- Original Message -----
From: "bert hubert" <ahu@ds9a.nl>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, January 04, 2002 4:00 PM
Subject: Re: How to debug very strange packet delivery problem?


> On Thu, Jan 03, 2002 at 09:38:50PM -0700, Kevin P. Fleming wrote:
> > I've got a machine that is just driving me nuts here... it's a RedHat
7.2
> > machine, upgraded to a 2.4.17 kernel (no kernel patches, just standard
> > kernel). The machine has an ethernet interface for it's local network,
and a
> > ppp interface (using RedHat's pppd-2.4.1 RPM) to connect it to the
corporate
> > WAN.
>
> Does your problem depend on kernel version?
>
> Regards,
>
> bert
>
> --
> http://www.PowerDNS.com          Versatile DNS Software & Services
> http://www.tk                              the dot in .tk
> Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
> Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc
>
>
>


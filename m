Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282492AbRLLWTP>; Wed, 12 Dec 2001 17:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282664AbRLLWTF>; Wed, 12 Dec 2001 17:19:05 -0500
Received: from mail7.cadvision.com ([207.228.64.92]:46863 "EHLO
	mail7.cadvision.com") by vger.kernel.org with ESMTP
	id <S282492AbRLLWSy>; Wed, 12 Dec 2001 17:18:54 -0500
Message-ID: <000701c1835b$5cca29e0$0100007f@localdomain.wni.com.wirelessnetworksinc.com>
From: "Herman Oosthuysen" <Herman@WirelessNetworksInc.com>
To: "Galappatti, Kishantha" <Kishantha.Galappatti@gs.com>,
        "'lkml'" <linux-kernel@vger.kernel.org>
In-Reply-To: <D28C5BE01ECBD41198ED00D0B7E4C9DA08E1AF3A@gsny31e.ny.fw.gs.com>
Subject: Re: Bluetooth support on Linux
Date: Wed, 12 Dec 2001 15:21:30 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are developing Linux based, Bluetooth access points (Engineering models
are available) and can soon supply mass produced USB dongles (factory is
building them now), but a generic Bluetooth driver isn't something that can
easily be included in the Kernel itself, since the modules are still
evolving too rapidly.  In a couple years it would probably be a different
matter when the module market has stabilized a bit.
--
Herman Oosthuysen
Herman@WirelessNetworksInc.com
Suite 300, #3016, 5th Ave NE,
Calgary, Alberta, T2A 6K4, Canada
Phone: (403) 569-5688, Fax: (403) 235-3965
----- Original Message -----
From: Galappatti, Kishantha <Kishantha.Galappatti@gs.com>
To: 'lkml' <linux-kernel@vger.kernel.org>
Sent: Wednesday, December 12, 2001 2:43 PM
Subject: Bluetooth support on Linux


> Is there a project to support Bluetooth in the kernel?  If so, can someone
> give me pointers to it. If not, any plans to? I know about the Axis and
> bluez projects.
>
> regds,
>
> --kish
>
>
> Kishantha Galappatti
> Senior Technology Analyst
> IMD Infrastructure
> Goldman Sachs Group Inc.
> 32 Old Slip, 9th Flr
> New York, NY 10005
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


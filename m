Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132472AbRCaSCs>; Sat, 31 Mar 2001 13:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132479AbRCaSCi>; Sat, 31 Mar 2001 13:02:38 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:46252 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S132472AbRCaSCX>; Sat, 31 Mar 2001 13:02:23 -0500
Date: Sat, 31 Mar 2001 12:00:41 -0600
From: "Glenn C. Hofmann" <hofmanng@swbell.net>
Subject: Re: VIA IDE driver status ?
In-Reply-To: <20010331004132.D111@pervalidus>
To: "=?ISO-8859-1?Q?Fr=E9d=E9ric?= L. W. Meunier" <0@pervalidus.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <986061646.10078.0.camel@hofmann1>
MIME-version: 1.0
X-Mailer: Evolution/0.10+cvs.2001.03.31.09.00 (Preview Release)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
In-Reply-To: <20010331004132.D111@pervalidus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure if this applies in your case, but I was getting problems
such as this on my Abit KT7-RAID and had the correct cables, also.  One
day, on a hunch after reading a post from Alan about overclocking, I
took my Athlon 750 down to 850 from 1.05 GHz and all is working great
now.  If your overclocking, I would suggest not doing so (at least not
so much), based on my experience.  I am also using the v4.0 driver.

Chris

  On 31 Mar 2001 00:41:32 -0300, Frédéric L. W. Meunier wrote:
> Hi. I really can't get UDMA66 with the VIA driver. I tried
> everything, also a new motherboard (ASUS A7Pro) with a
> ATA100/ATA66 cable (using both ends...)!
> 
> All I get are the usual CRC error messages.
> 
> So, there's no UDMA66 for any vt82c686a ? I'm using 2.4.3.
> 
> If there's no UDMA66, what are the advantages using this
> driver ?
> 
> TIA.
> 
> -- 
> 0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


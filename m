Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132481AbRCaSQA>; Sat, 31 Mar 2001 13:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132483AbRCaSPt>; Sat, 31 Mar 2001 13:15:49 -0500
Received: from 200-191-141-202-as.acessonet.com.br ([200.191.141.202]:47233
	"EHLO pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S132481AbRCaSPn>; Sat, 31 Mar 2001 13:15:43 -0500
Date: Sat, 31 Mar 2001 15:14:47 -0300
From: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.net>
To: "Glenn C. Hofmann" <hofmanng@swbell.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: VIA IDE driver status ?
Message-ID: <20010331151447.J111@pervalidus>
In-Reply-To: <20010331004132.D111@pervalidus> <986061646.10078.0.camel@hofmann1>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
In-Reply-To: <986061646.10078.0.camel@hofmann1>; from hofmanng@swbell.net on Sat, Mar 31, 2001 at 12:00:41PM -0600
X-Mailer: Mutt/1.3.16i - Linux 2.4.3
X-URL: http://www.pervalidus.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not overclocking. It's an ASUS A7Pro with Athlon 1000. I
had the same problem with an ASUS K7V with Athlon 700. But
the processor died after my cooler failed for 20 minutes!

BTW, how do I know if my cable is ATA100/ATA66, not only ATA66
? The manual from the A7Pro says it supports both, but at the
site it says the cable shipped with this motherboard is ATA66.

On Sat, Mar 31, 2001 at 12:00:41PM -0600, Glenn C. Hofmann wrote:
> I am not sure if this applies in your case, but I was getting problems
> such as this on my Abit KT7-RAID and had the correct cables, also.  One
> day, on a hunch after reading a post from Alan about overclocking, I
> took my Athlon 750 down to 850 from 1.05 GHz and all is working great
> now.  If your overclocking, I would suggest not doing so (at least not
> so much), based on my experience.  I am also using the v4.0 driver.
> 
> Chris
> 
>   On 31 Mar 2001 00:41:32 -0300, Frédéric L. W. Meunier wrote:
> > Hi. I really can't get UDMA66 with the VIA driver. I tried
> > everything, also a new motherboard (ASUS A7Pro) with a
> > ATA100/ATA66 cable (using both ends...)!
> > 
> > All I get are the usual CRC error messages.
> > 
> > So, there's no UDMA66 for any vt82c686a ? I'm using 2.4.3.
> > 
> > If there's no UDMA66, what are the advantages using this
> > driver ?
> > 
> > TIA.

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265772AbUFXVy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUFXVy7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUFXVx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:53:29 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:9432 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S265772AbUFXVtf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:49:35 -0400
Date: Thu, 24 Jun 2004 17:49:23 -0400
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: Chad Kitching <CKitching@powerlandcomputers.com>
Cc: Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: alienware hardware
Message-ID: <20040624214923.GZ728@washoe.rutgers.edu>
Mail-Followup-To: Chad Kitching <CKitching@powerlandcomputers.com>,
	Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <18DFD6B776308241A200853F3F83D5072817@pl6w2kex.lan.powerlandcomputers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18DFD6B776308241A200853F3F83D5072817@pl6w2kex.lan.powerlandcomputers.com>
X-Image-Url: http://www.onerussian.com/img/yoh.png
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I remember I've tried to boot 2.6.6 kernel included with debian (they
have pretty much everything in modules) with pci=noacpi and acpi=off
options... it didn't help - it was slow as hell... 

I will try again with them and this kernel shortly. Thanx for advice

--
Yarik

On Thu, Jun 24, 2004 at 04:42:33PM -0500, Chad Kitching wrote:
> Have you tried booting with noapic, nolapic, noioapic and/or acpi=off? 
> Unfortunately since you compiled all your drivers into the kernel, 
> asking you to try without loading any of them won't work without a 
> recompile.

> > -----Original Message-----
> > From: Yaroslav Halchenko [mailto:yoh@psychology.rutgers.edu]
> > Sent: June 24, 2004 4:10 PM
> > Subject: Re: alienware hardware


> > it is seems to be more general problem, because it slows down not only
> > dpkg process - booting on 2.4.26 kernel takes about 5 minutes to
> > complete and of cause no dpkg is involved in that process.

> > I took dpkg as just single example, I don't what to try else on...
> > bogomips reports about 50% of what is in /proc/cpuinfo, so it looks
> > normal... I'm suspecting IDE, so it looks like when app has 
> > to work with
> > HDD then it slows down although HDD bulb doesn't report an 
> > activity....
> > but I might be wrong. btw - I will put hdparm as well on the
> > webpage

> > We are about to setup X on that beast and I will try may be some other
> > programs... suggestions?


-- 
                                                  Yaroslav Halchenko
                  Research Assistant, Psychology Department, Rutgers
          Office  (973) 353-5440 x263
   Ph.D. Student  CS Dept. NJIT
             Key  http://www.onerussian.com/gpg-yoh.asc
 GPG fingerprint  3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8


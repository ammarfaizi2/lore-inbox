Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVC2GcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVC2GcO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 01:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbVC2GcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 01:32:13 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:51614 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262452AbVC2G3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 01:29:53 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Reuben Farrelly <reuben-lkml@reub.net>
Subject: Re: 2.6.12-rc1-mm3
Date: Tue, 29 Mar 2005 01:29:51 -0500
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rmk+serial@arm.linux.org.uk
References: <fa.h3qui0k.n6uf30@ifi.uio.no> <4247DCBE.7020900@reub.net>
In-Reply-To: <4247DCBE.7020900@reub.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503290129.51566.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 March 2005 05:30, Reuben Farrelly wrote:
> Hi,
> 
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm3/
> > 
> > - Mainly a bunch of fixes relative to 2.6.12-rc1-mm2.
> > 
> > - Again, we'd like people who have had recent DRM and USB resume problems to
> >   test and report, please.
> > 
> > - The bk-ide-dev tree is back after a couple of weeks of difficulties.
> > 
> > - Jeff asks that anyone who has had problems with the Silicon Image SATA
> >   drivers test sata_sil-corruption--lockup-fix.patch, which is included in
> >   this kernel.
> 
> I'm repeatably getting this crash on shutdown in -mm3, and a few 
> releases earlier (but I can't be certain it was the same crash..)
>

It would be nice to know when it started breaking... At least point release,
not -rc or -bk.

-- 
Dmitry

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291942AbSBTPlK>; Wed, 20 Feb 2002 10:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291935AbSBTPkv>; Wed, 20 Feb 2002 10:40:51 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:39563 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S291934AbSBTPkn>; Wed, 20 Feb 2002 10:40:43 -0500
Date: Wed, 20 Feb 2002 16:40:31 +0100
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-rcx: Dual P3 + VIA + APIC
Message-ID: <20020220154031.GU13774@os.inf.tu-dresden.de>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020220104129.GP13774@os.inf.tu-dresden.de> <E16dYbm-0003pu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E16dYbm-0003pu-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Feb 20, 2002 at 15:24:38 +0000, Alan Cox wrote:
> > trying to boot a 2.4.18-rc1, 2.4.18-rc2-ac1 or 2.5.5pre1 on a dual P3
> > with a VIA chipset hangs (randomly) at the "=====" signs, sometimes the
> > screen is flickering:
> Does 2.4.18pre8 work ? There is a small MP 1.4 change I tested and fed on
> to Marcelo and it would be nice to know that wasnt the cause

No, same symptoms, hangs on several places and screen flickers
sometimes.



Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://a.home.dhs.org

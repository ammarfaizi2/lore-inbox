Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267223AbUHaTcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267223AbUHaTcX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268988AbUHaTba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:31:30 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:60854 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S269019AbUHaT0f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:26:35 -0400
From: Norberto Bensa <nbensa@gmx.net>
To: gene.heskett@verizon.net
Subject: Re: 2.6.9-rc1-mm2 nvidia breakage
Date: Tue, 31 Aug 2004 16:26:21 -0300
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, jason@stdbev.com,
       Sid Boyce <sboyce@blueyonder.co.uk>, akpm@osdl.org
References: <4134A5EE.5090003@blueyonder.co.uk> <200408311448.55974.norberto+linux-kernel@bensa.ath.cx> <200408311459.12426.gene.heskett@verizon.net>
In-Reply-To: <200408311459.12426.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408311626.22004.nbensa@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Tuesday 31 August 2004 13:48, Norberto Bensa wrote:
> >Jason Munro wrote:
> >> I also had to change calls to pci_find_class in nv.c to
> >> pci_get_class to get the module to load with 2.6.9-rc1-mm2.
> >
> >Yup. But KDE 3.3 doesn't load with this kernel. No oops, no crash.
> > It just hangs at "Initializing peripherals..." and stays there
> > forever...
>
> Odd, I'm running kde3.3 built by konstruct, and linux-2.6.9-rc1-mm2
> without any quickly noticeable problems, for about 15 minutes now.

kbuildsycoca hangs. Again, no crash, no oops, no strange messages except 
kbuildsycoca hangs and ksplash's "initializing peripherals" icon keeps 
blinking.

I don't know what to report since there are no strange messages; I'm stuck.

Thanks Gene.

Best regards,
Norberto

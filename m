Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUI0Py2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUI0Py2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266566AbUI0Py1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:54:27 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:42131 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S266513AbUI0Pwo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:52:44 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproductions.com
To: gene.heskett@verizon.net
Subject: Re: 2.6.9-rc2-mm4
Date: Mon, 27 Sep 2004 08:52:43 -0700
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409270706.21661.lkml@lpbproductions.com> <200409271131.27329.gene.heskett@verizon.net>
In-Reply-To: <200409271131.27329.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409270852.44366.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 September 2004 8:31 am, Gene Heskett wrote:
> ones to be effected, so lets compare notes:
>
> AMD Athlon 2800xp, biostar N7-NCD-Pro motherboard with an nforce2
> chipset, and using the forcedeth driver for eth0.  A gigabyte of
> DDR400 rated ram running in DDR333 dual channel mode, the 2800xp
> Athlon can't handle the DDR400 fsb correctly. No acpi is enabled, and
> apm only for shutdown control & rtc handling.
>

Simular system here. Athlon 3000xp , with nforce2 chipset. 

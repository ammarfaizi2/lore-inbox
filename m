Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbVJZNQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbVJZNQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 09:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbVJZNQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 09:16:09 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:4974 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751490AbVJZNQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 09:16:08 -0400
Date: Wed, 26 Oct 2005 15:16:04 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Deven Balani <devenbalani@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: reference code for non-PCI libata complaint SATA for ARM boards.
Message-ID: <20051026131604.GA24567@harddisk-recovery.com>
References: <7a37e95e0510250511g631db9edoe4c739ed24b7a79b@mail.gmail.com> <1130254633.25191.33.camel@localhost.localdomain> <435E6D55.7090903@pobox.com> <7a37e95e0510252258k621b46efj4d37c2ceed00dfeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a37e95e0510252258k621b46efj4d37c2ceed00dfeb@mail.gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2005 at 11:28:10AM +0530, Deven Balani wrote:
> But I have a problem my other drivers are 2.4.25 compliant. So it is
> a huge work
> to make all other drivers 2.6 compliant and use libata-core.c.
> I believe it is far more easier to have 2.4.x libata rather than
> porting my drivers to
> 2.6.x.

Porting drivers to 2.6 isn't too hard. LWN has a nice tutorial, see
http://lwn.net/Articles/driver-porting/ .

> What do you suggest me ?

Use 2.6, especially with new hardware. The 2.4 kernel on ARM is no
longer supported, all development has moved to 2.6 almost two years
ago.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands

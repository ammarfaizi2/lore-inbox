Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbTLIO4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265945AbTLIOyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:54:47 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:39824 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S265944AbTLIOyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:54:09 -0500
Subject: Re: sensors vs 2.6
From: Stian Jordet <liste@jordet.nu>
To: gene.heskett@verizon.net
Cc: Sebastian Kaps <seb-keyword-linux.637a6e@toyland.sauerland.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200312090741.31290.gene.heskett@verizon.net>
References: <200312090258.01944.gene.heskett@verizon.net>
	 <m3zne21dsw.fsf@toyland.sauerland.de>
	 <200312090741.31290.gene.heskett@verizon.net>
Content-Type: text/plain
Message-Id: <1070981656.26479.7.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 15:54:16 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 09.12.2003 kl. 13.41 skrev Gene Heskett:
> I have this:
> -----------------------
> [root@coyote linux-2.6]# grep I2C .config
> # I2C support
> CONFIG_I2C=y
> CONFIG_I2C_CHARDEV=y
> # I2C Algorithms
> CONFIG_I2C_ALGOBIT=y
> # CONFIG_I2C_ALGOPCF is not set
> # I2C Hardware Bus support
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_I810 is not set
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_PHILIPSPAR is not set
> # CONFIG_I2C_PIIX4 is not set
> # CONFIG_I2C_PROSAVAGE is not set
> # CONFIG_I2C_SAVAGE4 is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> CONFIG_I2C_VIA=y
> CONFIG_I2C_VIAPRO=y
> # CONFIG_I2C_VOODOO3 is not set
> # I2C Hardware Sensors Chip support
> CONFIG_I2C_SENSOR=y

You seem to be missing support for a sensor chip.

Best regards,
Stian


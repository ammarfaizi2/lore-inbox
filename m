Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266053AbTLIPcl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 10:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266054AbTLIPck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 10:32:40 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:12433 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S266053AbTLIPcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 10:32:39 -0500
Subject: Re: sensors vs 2.6
From: Stian Jordet <liste@jordet.nu>
To: gene.heskett@verizon.net
Cc: Sebastian Kaps <seb-keyword-linux.637a6e@toyland.sauerland.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200312091021.42283.gene.heskett@verizon.net>
References: <200312090258.01944.gene.heskett@verizon.net>
	 <200312090741.31290.gene.heskett@verizon.net>
	 <1070981656.26479.7.camel@chevrolet.hybel>
	 <200312091021.42283.gene.heskett@verizon.net>
Content-Type: text/plain
Message-Id: <1070983964.26479.12.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 16:32:44 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 09.12.2003 kl. 16.21 skrev Gene Heskett:
> [root@coyote linux-2.6]# grep SENSORS .config
> # CONFIG_SENSORS_ADM1021 is not set
> CONFIG_SENSORS_EEPROM=y
> # CONFIG_SENSORS_IT87 is not set
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM78 is not set
> # CONFIG_SENSORS_LM85 is not set
> CONFIG_SENSORS_VIA686A=y
> CONFIG_SENSORS_W83781D=y

Sorry, I'm stupid. I didn't notice you just grepped after i2c, I just
thought you had copied the entire i2c section from .config. Sorry. That
should cover it.

Best regards,
Stian


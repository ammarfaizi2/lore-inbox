Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271374AbTGWXFO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 19:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271372AbTGWXFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 19:05:14 -0400
Received: from 69.Red-217-126-207.pooles.rima-tde.net ([217.126.207.69]:21768
	"EHLO server01.nullzone.prv") by vger.kernel.org with ESMTP
	id S271374AbTGWXFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 19:05:05 -0400
Message-Id: <5.2.1.1.2.20030724011628.00bb6d38@192.168.2.130>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Thu, 24 Jul 2003 01:20:20 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: system_lists@nullzone.org
Subject: Re: Problems with IDE - Ultra-ATA devices on a SiI chipset IDE
  controler
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1059000564.6898.24.camel@dhcp22.swansea.linux.org.uk>
References: <5.2.1.1.2.20030721173557.00d56450@192.168.2.130>
 <5.2.1.1.2.20030721173557.00d56450@192.168.2.130>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

    I am just using 2.4.21 kernel version (standard drivers of this kernel).

Let me know if could be useful to send more information or if you need that 
I do some tests (let me know what you need and i will do).

Thanks.

At 23:49 23/07/2003 +0100, Alan Cox wrote:
>What drives and kernel revision are you using. I have fixed some SI680
>problems fairly recently but I'd have expected different failure
>patterns (the old code would put some UDMA100 devices into UDMA133 which
>got interesting).
>
>Yes folks you *can* overclock IDE disks but its not a good idea





Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUBWMih (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 07:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUBWMih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 07:38:37 -0500
Received: from catv-5062a04e.szolcatv.broadband.hu ([80.98.160.78]:62733 "EHLO
	catv-5062a04e.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S261786AbUBWMif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 07:38:35 -0500
Message-ID: <4039F443.30204@freemail.hu>
Date: Mon, 23 Feb 2004 13:38:27 +0100
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu; rv:1.6) Gecko/20040115
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise TX2plus PATA port?
References: <4039B8AF.9060002@freemail.hu>
In-Reply-To: <4039B8AF.9060002@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boszormenyi Zoltan írta:
> Hi,
> 
> how can I make it work? The BIOS recognizes the drive
> (jumpered as master) but 2.6.3-mm2 does not. Device id is 0x3373.
> pdc202xx_new, pdc202xx_old and sata_promise drivers
> are compiled in. Motherboard is an MSI K8T Neo FIS2R.
> The 120GB Samsung and the Sony CRX300E DVD/CDRW combo
> are recognized by both the BIOS and the kernel.

Needless to say that those devices are attached to the VIA
IDE ports, that works OK. BTW all PATA and SATA host drivers
are compiled in. The Promise SATA378 TX2plus PATA port still
does not work.

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263936AbTKZDDc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 22:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbTKZDDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 22:03:32 -0500
Received: from CPE-65-30-34-80.kc.rr.com ([65.30.34.80]:62360 "EHLO
	cognition.home.hanaden.com") by vger.kernel.org with ESMTP
	id S263936AbTKZDDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 22:03:30 -0500
Message-ID: <3FC41800.2020400@hanaden.com>
Date: Tue, 25 Nov 2003 21:03:28 -0600
From: Hanasaki JiJi <hanasaki@hanaden.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031004
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: via kt600 based motherboard compatibility
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

been looking and googling for hours... and haven't found a definitive
answer.

Anyone know if, and how well, the following is supported?

================
Asus A7V600
http://www.asus.com/prog/spec.asp?m=A7V600&langs=01
	- ADI AD1980 audio sound
	- eCom 3C940 gigabit ethernet
		does it have a driver?
		does it work on 10/100 too?

================
Soyo sy-kt600 Dragon+ v1.0
http://www.soyousa.com/products/proddesc.php?id=280
	- VIA 1616 audio sound
	- VIA VT6307 IEEE1394 - firewire
	- chip?  10/100 ethernet

================
Soyo sy-kt600 Dragon Ultra Platinum
	- CMI 8738 - audio sound
		- kernel 2.4.x and 2.6 has support
	- VT6306 Firewire 1394
	- BCM5705K gigabit ethernet
		does it have a driver?
		does it work on 10/100 too?
	- Silicon Image SIL3112 - SATA
	- 8237 SATA/IDE
	* yes it has both SATA chips and support 4 SATA

================
Gigabyte GA-7V600 1394
http://www.giga-byte.com/MotherBoard/Products/Products_Spec_GA-7VT600%201394.htm
	- Realtek ALC655 sound
	- VIA VT6306 IEEE1394 - firewire
	- RTL8101L - Ethernet network
	- IO - IT8705
	- 8237 SATA/USB

*** what is the ordering of the sound chips, above, from best worst?
	ADI AD1980
	CMI 8738
	VIA 1616
	RT ALC655

*** notice the slightly different firewire chips
	6307 vs 6306

Thank you all for your responses!



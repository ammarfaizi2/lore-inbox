Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279787AbRKFQVy>; Tue, 6 Nov 2001 11:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279717AbRKFQVp>; Tue, 6 Nov 2001 11:21:45 -0500
Received: from mail126.mail.bellsouth.net ([205.152.58.86]:50935 "EHLO
	imf26bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279778AbRKFQVg>; Tue, 6 Nov 2001 11:21:36 -0500
Message-ID: <3BE80E02.534C680F@mandrakesoft.com>
Date: Tue, 06 Nov 2001 11:21:22 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chun-Ying Huang <huangant@cis.nctu.edu.tw>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with gigabit NIC acenic: 3c985b-sx
In-Reply-To: <3BE80A55.95F73193@cis.nctu.edu.tw>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chun-Ying Huang wrote:
> 
>     Dear all:
> 
>         I've install a 3c985b-sx NIC on my linux 2.4.13 box.
>         But when loading the 'acenic' module, it shows the message:
> 
> eth1: 3Com 3C985 Gigabit Ethernet at 0xdf020000, irq 10
>   Tigon II (Rev. 6), Firmware: 12.4.11, MAC: 00:60:08:f7:04:1e
>   PCI bus width: 32 bits, speed: 33MHz, latency: 64 clks
> eth1: Firmware NOT running!

should be fixed in 2.4.14.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno


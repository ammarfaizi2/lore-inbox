Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281183AbRKLANQ>; Sun, 11 Nov 2001 19:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281184AbRKLANH>; Sun, 11 Nov 2001 19:13:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38409 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281183AbRKLAM4>; Sun, 11 Nov 2001 19:12:56 -0500
Subject: Re: CS4281 on Dell Inspiron 2100 running Redhat 7.2
To: dong@ucolick.org (Shawfeng Dong)
Date: Mon, 12 Nov 2001 00:19:51 +0000 (GMT)
Cc: twoller@crystal.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <000701c16a72$699ac050$70167280@usa> from "Shawfeng Dong" at Nov 10, 2001 09:33:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1634pM-00040o-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> into Linux. But there is a weird problem: if I reboot the computer from W2k
> into Linux, it is unable to load the sound driver.
> 
> Do you have any idea what may cause this weird behavior? Or can you send me
> the latest driver? If you need more detailed information, please let me
> know.

Windows leaves the hardware shutdown in a state Linux can't get it back.
The same happens in reverse sometimes too. Basically always cold boot
when changing OS 

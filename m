Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317547AbSHCM3N>; Sat, 3 Aug 2002 08:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317550AbSHCM3N>; Sat, 3 Aug 2002 08:29:13 -0400
Received: from pD952AC04.dip.t-dialin.net ([217.82.172.4]:31685 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317547AbSHCM3N>; Sat, 3 Aug 2002 08:29:13 -0400
Date: Sat, 3 Aug 2002 06:32:30 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Harald Dunkel <harri@synopsys.COM>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.4.19
In-Reply-To: <3D4BCA19.2040802@Synopsys.COM>
Message-ID: <Pine.LNX.4.44.0208030631580.5119-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 3 Aug 2002, Harald Dunkel wrote:
> PS: After booting 2.4.19 'depmod -a' works as expected, but
>      'depmod -ae -F /boot/System.map-2.4.19 2.4.19' doesn't. I
>      would guess its a problem with depmod.

I'd rather guess the problem is that you didn't make dep after config 
changes. Read the FAQ, please.

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSHYK5O>; Sun, 25 Aug 2002 06:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSHYK5O>; Sun, 25 Aug 2002 06:57:14 -0400
Received: from pD9E236A6.dip.t-dialin.net ([217.226.54.166]:46504 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317189AbSHYK5N>; Sun, 25 Aug 2002 06:57:13 -0400
Date: Sun, 25 Aug 2002 05:01:19 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Volker Kuhlmann <list0570@paradise.net.nz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel losing time
In-Reply-To: <20020825105500.GE11740@paradise.net.nz>
Message-ID: <Pine.LNX.4.44.0208250459500.3234-100000@hawkeye.luckynet.adm>
X-Location: Potsdam-Babelsberg; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 25 Aug 2002, Volker Kuhlmann wrote:
> I am stuck with a kernel problem someone can hopefully shed some light
> on. It's also a bug report.

And it's already known. It's VIA chipset which obviously can't read the 
clock ;-) Chipset kicking wrong interrupts, timer can't help it.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-


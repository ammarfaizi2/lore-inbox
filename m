Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317799AbSHDO2L>; Sun, 4 Aug 2002 10:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317802AbSHDO2L>; Sun, 4 Aug 2002 10:28:11 -0400
Received: from [196.26.86.1] ([196.26.86.1]:20938 "EHLO
	infosat-gw.realnet.co.sz") by vger.kernel.org with ESMTP
	id <S317799AbSHDO2K>; Sun, 4 Aug 2002 10:28:10 -0400
Date: Sun, 4 Aug 2002 16:47:17 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Thunder from the hill <thunder@ngforever.de>
Cc: Daniel Phillips <phillips@arcor.de>, Andrew Morton <akpm@zip.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Rmap speedup
In-Reply-To: <Pine.LNX.4.44.0208040809470.10270-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0208041645220.18230-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Aug 2002, Thunder from the hill wrote:

> On Sun, 4 Aug 2002, Daniel Phillips wrote:
> > Look again: 256 - 16 = 250 = 0xf0.
> 
> What's your maths?! 256d - 16d = 0xff - 0xf = 0xf0 = 240d!

I believe that was a typo, but the final answer was obviously correct. No 
need to get into a hissy..

	Zwane

-- 
function.linuxpower.ca



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSHYLNR>; Sun, 25 Aug 2002 07:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317257AbSHYLNR>; Sun, 25 Aug 2002 07:13:17 -0400
Received: from pD9E236A6.dip.t-dialin.net ([217.226.54.166]:59048 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317253AbSHYLNR>; Sun, 25 Aug 2002 07:13:17 -0400
Date: Sun, 25 Aug 2002 05:17:24 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Volker Kuhlmann <list0570@paradise.net.nz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] make localconfig
In-Reply-To: <20020825110251.GF11740@paradise.net.nz>
Message-ID: <Pine.LNX.4.44.0208250515250.3234-100000@hawkeye.luckynet.adm>
X-Location: Potsdam-Babelsberg; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 25 Aug 2002, Volker Kuhlmann wrote:
> Even with code noone seems to have taken heed. The code has been
> available for ages. I think it's very useful.

I think you're talking about different code.

> gunzip </proc/config.gz gives you the config of the running kernel,

What if the current kernel is some allmodconfig, and you don't want that, 
for some reason? And by the way, that's not related to the transition I 
mentioned. If you want that, just go and do make allmodconfig.

> make cloneconfig

Why not make oldconfig?

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-


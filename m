Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317078AbSHBVxH>; Fri, 2 Aug 2002 17:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSHBVxH>; Fri, 2 Aug 2002 17:53:07 -0400
Received: from pD952AC04.dip.t-dialin.net ([217.82.172.4]:30913 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317078AbSHBVxG>; Fri, 2 Aug 2002 17:53:06 -0400
Date: Fri, 2 Aug 2002 15:56:30 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Olivier Beau <piaf@evc.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Little bug in the 2.5.9 release
In-Reply-To: <20020802232944.GA11386@piaf.local>
Message-ID: <Pine.LNX.4.44.0208021555570.5119-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 3 Aug 2002, Olivier Beau wrote:
> There is a duplicate definition in init/main.c at the lines 275 and 279.

Indeed. Linus had the patch double-applied, IIRC. However, it was fixed in 
2.5.10.

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSHJGZn>; Sat, 10 Aug 2002 02:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSHJGZn>; Sat, 10 Aug 2002 02:25:43 -0400
Received: from pD952AEB1.dip.t-dialin.net ([217.82.174.177]:45449 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316610AbSHJGZm>; Sat, 10 Aug 2002 02:25:42 -0400
Date: Sat, 10 Aug 2002 00:29:13 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "David S. Miller" <davem@redhat.com>
cc: thunder@lightweight.ods.org, <lkml@procter-collective.org.uk>,
       <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: Unix-domain sockets - abstract addresses
In-Reply-To: <20020809.180500.87139790.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0208100028420.10270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 9 Aug 2002, David S. Miller wrote:
>    +#undef unix	/* KBUILD_MODNAME */
>    +
> 
> Explain to me what this giblet is for?

Piece of the automagic modinit patch... Shouldn't be there...

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-


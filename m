Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSH0PVt>; Tue, 27 Aug 2002 11:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSH0PVt>; Tue, 27 Aug 2002 11:21:49 -0400
Received: from pD9E23A01.dip.t-dialin.net ([217.226.58.1]:56504 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316289AbSH0PVs>; Tue, 27 Aug 2002 11:21:48 -0400
Date: Tue, 27 Aug 2002 09:25:06 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Horst von Brand <vonbrand@eeyore.valparaiso.cl>
cc: Robert Love <rml@tech9.net>, <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make raid5 checksums preempt-safe 
In-Reply-To: <200208270138.g7R1ckGx001985@eeyore.valparaiso.cl>
Message-ID: <Pine.LNX.4.44.0208270924130.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 26 Aug 2002, Horst von Brand wrote:
> Also, kindly place "do { ... } while(0)" around XMMS_SAVE, if only for
> symmetry.

We've already had that talked about. Will appear in one of the following 
patches.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316664AbSGGXjq>; Sun, 7 Jul 2002 19:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316666AbSGGXjp>; Sun, 7 Jul 2002 19:39:45 -0400
Received: from zork.zork.net ([66.92.188.166]:33190 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S316664AbSGGXjp>;
	Sun, 7 Jul 2002 19:39:45 -0400
Date: Mon, 8 Jul 2002 00:42:24 +0100
From: Sean Neakums <sneakums@zork.net>
To: linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020707234224.GF20165@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3D28CD73.9000601@us.ibm.com> <Pine.LNX.4.44.0207071730390.10105-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207071730390.10105-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.28i
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text advisory: STYLE OVER SUBSTANCE, IGNORATIO ELENCHI
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Thunder from the hill  quotation:
> We should rename it to something that actually tells you what it does. 
> BTW, when was lock_kernel()? It must be really old if it still locked the 
> whole kernel.

It was added during the 1.3 development phase.  Dave's paper in the
OLS proceedings (that was yours, wasn't it?) covers it pretty nicely
(at least to my kernel-ignorant eyes).

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |

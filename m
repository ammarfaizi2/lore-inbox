Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289754AbSAOX2R>; Tue, 15 Jan 2002 18:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289752AbSAOX2I>; Tue, 15 Jan 2002 18:28:08 -0500
Received: from monster.gotadsl.co.uk ([213.208.127.236]:9634 "EHLO
	monster.gotadsl.co.uk") by vger.kernel.org with ESMTP
	id <S289759AbSAOX1w>; Tue, 15 Jan 2002 18:27:52 -0500
Subject: Re: [patch] O(1) scheduler, -I1
From: Craig Knox <crg@monster.gotadsl.co.uk>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020115.234823.884032698.rene.rebe@gmx.net>
In-Reply-To: <Pine.LNX.4.40.0201150915590.1460-100000@blue1.dev.mcafeelabs.com>
	<Pine.LNX.4.33.0201152022590.14517-100000@localhost.localdomain> 
	<20020115.234823.884032698.rene.rebe@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 15 Jan 2002 23:30:51 +0000
Message-Id: <1011137451.1142.13.camel@crgs.lowerrd.prv>
Mime-Version: 1.0
X-Scanner: exiscan *16QczU-0003rj-00*Efq2LvjK96E* (monster.gotadsl.co.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just tried the sched-O1-2.4.17-I0.patch and interactive performance
> is unbelieveable bad!

I've noticed that it seems bad as well.  The earlier releases have been
great.
With the 2.4.17-I0 patch my mouse jerks around the screen when compiling
a kernel on a dual PII450.


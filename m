Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319555AbSIMIM6>; Fri, 13 Sep 2002 04:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319557AbSIMIM6>; Fri, 13 Sep 2002 04:12:58 -0400
Received: from denise.shiny.it ([194.20.232.1]:35230 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S319555AbSIMIM5>;
	Fri, 13 Sep 2002 04:12:57 -0400
Message-ID: <XFMail.20020913101747.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44.0209121223470.10048-100000@hawkeye.luckynet.adm>
Date: Fri, 13 Sep 2002 10:17:47 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Thunder from the hill <thunder@lightweight.ods.org>
Subject: RE: Killing/balancing processes when overcommited
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Probably we do need an oomd that the sysadmin can configure as he likes.
>
> That's bad, it could get killed. ;-)

Not if it's the only killer.

> Mostly the mem eaters are those who hang in an malloc() deadloop.

And what about a make -j ? The offender is not always one memory hog.


Bye.

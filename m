Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319042AbSHTOcP>; Tue, 20 Aug 2002 10:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319046AbSHTOcO>; Tue, 20 Aug 2002 10:32:14 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:36091 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319042AbSHTOcM>; Tue, 20 Aug 2002 10:32:12 -0400
Subject: Re: hpt374 / BUG();
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jools <j1@gramstad.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <IOELJIHGBNLBJNBMHABBIEPOCCAA.j1@gramstad.org>
References: <IOELJIHGBNLBJNBMHABBIEPOCCAA.j1@gramstad.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Aug 2002 15:36:49 +0100
Message-Id: <1029854209.22983.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-20 at 15:10, jools wrote:
> Hi
> 
> I'm using a RocketRAID 404 (hpt374) and a Asus A7v266.
> When trying to boot from a 'htp374-enabled' kernel like 2.4.19-ac4 or
> 2.4.20-pre2-ac4, i keep getting kernel panic at hpt366.c:1393.
> Does anyone know why this happens, or what I might do to correct this
> problem? I have tried every patch I can find for the 2.4 kernel.

Please try the next -ac when it appears. I've changed the bugs to error
back more intelligently so hopefully you'll get a sensible response even
though you want get UDMA


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbSJVVIP>; Tue, 22 Oct 2002 17:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264769AbSJVVIP>; Tue, 22 Oct 2002 17:08:15 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:17339 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264625AbSJVVIO>; Tue, 22 Oct 2002 17:08:14 -0400
Subject: Re: feature request - why not make netif_rx() a pointer?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Slavcho Nikolov <snikolov@okena.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <00b201c27a0e$3f82c220$800a140a@SLNW2K>
References: <00b201c27a0e$3f82c220$800a140a@SLNW2K>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 22:30:40 +0100
Message-Id: <1035322240.31917.177.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 22:01, Slavcho Nikolov wrote:
> Non GPL modules that want to attach themselves between all L2 drivers and
> upper layers would not have to incur a performance loss if netif_rx() is

You could of course write GPL code 8)


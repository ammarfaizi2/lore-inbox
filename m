Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbSLYVWN>; Wed, 25 Dec 2002 16:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261337AbSLYVWM>; Wed, 25 Dec 2002 16:22:12 -0500
Received: from m83-mp1.cvx2-c.ren.dial.ntli.net ([62.252.152.83]:41461 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S261333AbSLYVWK>; Wed, 25 Dec 2002 16:22:10 -0500
Subject: Re: [PATCH] 2.4.20/drivers/ide/pdc202xx.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nikolai Zhubr <s001@hotbox.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <1876003973.20021224013519@hotbox.ru>
References: <1876003973.20021224013519@hotbox.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Dec 2002 21:29:05 +0000
Message-Id: <1040851745.1109.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-23 at 22:35, Nikolai Zhubr wrote:
> Hi, this patch fixes misdetection of 80-pin vs 40-pin IDE cable
> connected to Promise 202xx IDE controller (kernel 2.4.20). The original

2.4.21pre updates the IDE massively. This should already be fixed


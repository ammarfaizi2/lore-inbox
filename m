Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267352AbSLEQ6i>; Thu, 5 Dec 2002 11:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267359AbSLEQ6i>; Thu, 5 Dec 2002 11:58:38 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:18601 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267352AbSLEQ5S>; Thu, 5 Dec 2002 11:57:18 -0500
Subject: Re: stock 2.4.20: loading amd76x_pm makes time jiggle on A7M266-D
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kay Diederichs <kay.diederichs@uni-konstanz.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DEF26D3.7A4236D7@uni-konstanz.de>
References: <3DEDF543.51C80677@uni-konstanz.de>
	<1039009531.15353.13.camel@irongate.swansea.linux.org.uk> 
	<3DEF26D3.7A4236D7@uni-konstanz.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Dec 2002 17:39:30 +0000
Message-Id: <1039109970.19681.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-05 at 10:13, Kay Diederichs wrote:
> installed the latest glibc-2.2.4-31 from redhat/7.2/updates but still
> init fails. Are there RH7.2 compatible versions of glibc which are
> TSC-checking?

The -i386 one rather than the -i686 one


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSINNYZ>; Sat, 14 Sep 2002 09:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSINNYZ>; Sat, 14 Sep 2002 09:24:25 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:6386 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316573AbSINNYY>; Sat, 14 Sep 2002 09:24:24 -0400
Subject: Re: 2.4.20-pre7 config errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hans-Joachim Baader <hjb@pro-linux.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020914084436.GC6178@mandel.hjbaader.home>
References: <20020914084436.GC6178@mandel.hjbaader.home>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 14 Sep 2002 14:30:53 +0100
Message-Id: <1032010253.12892.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-14 at 09:44, Hans-Joachim Baader wrote:
> Hi!
> 
> In certain configurations (small or minimal), with "make menuconfig",
> it is not possible to enter the submenus for
> 
>  Fusion MPT device support
>  ISDN support
>  I2O device support
> 
> I don't know on which configuration these depend, but it would be nice if
> they told the user the reason rather than doing nothing.

Its a limitation of the configuration tools


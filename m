Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSJ1TON>; Mon, 28 Oct 2002 14:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbSJ1TON>; Mon, 28 Oct 2002 14:14:13 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:1233 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261524AbSJ1TNz>; Mon, 28 Oct 2002 14:13:55 -0500
Subject: Re: crc error on boot (2.4.20-pre11 gcc 3.2-mdk)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Max Valdez <maxvaldez@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1035810541.2675.3.camel@garaged.fis.unam.mx>
References: <1035810541.2675.3.camel@garaged.fis.unam.mx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Oct 2002 19:39:04 +0000
Message-Id: <1035833944.3551.58.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-28 at 13:09, Max Valdez wrote:
> Hi all
> 
> I think I'm about to make a stupid question, but still can contain...
> 
> Is gcc 3.2 supported to build linux kernel ???, any known problems ???
> 
> I have a "crc error" in the first step of the booting process, just
> after lilo screen goes off.
> 
> I attach my config file, It's the first time i try to build a kernel
> with gcc 3.2, I havent had big problems before ( gcc 2.9X ) on mandrake
> and redhat.

I build with the RH shipped gcc 3.2 which seems to work great except for
a lot of compile warnings. Shouldn't be a problem


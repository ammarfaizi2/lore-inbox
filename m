Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267416AbSKQANh>; Sat, 16 Nov 2002 19:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267417AbSKQANh>; Sat, 16 Nov 2002 19:13:37 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:47281 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267416AbSKQANg>; Sat, 16 Nov 2002 19:13:36 -0500
Subject: Re: PC-9800 on 2.5.47-ac5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3DD6DADC.F5BE96E6@cinet.co.jp>
References: <3DD6DADC.F5BE96E6@cinet.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Nov 2002 00:47:28 +0000
Message-Id: <1037494049.24777.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-16 at 23:55, Osamu Tomita wrote:
> Thanks Alan. 2.5.47-ac5 works fine for my PC-9800 box
>  with additional patch. I put additional patch next URL.
> http://downloads.sourceforge.jp/linux98/1561/linux98-2.5.47-ac5.patch.tar.bz2


Thanks - I'm trying to fold bits in one at a time and to avoid lots of
messy ifdefs. BTW - have you tested the APM change as it seems to have
more pushes than pops for the stack ?

Also for the 386/486 crash was that with our without FPU and software
FPU emulation ?


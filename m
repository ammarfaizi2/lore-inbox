Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbSKJTkO>; Sun, 10 Nov 2002 14:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265127AbSKJTkO>; Sun, 10 Nov 2002 14:40:14 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:14753 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265126AbSKJTkN>; Sun, 10 Nov 2002 14:40:13 -0500
Subject: Re: BOGUS: megaraid changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.E.J. Bottomley" <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200211101904.gAAJ4RX12573@localhost.localdomain>
References: <200211101904.gAAJ4RX12573@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Nov 2002 20:11:14 +0000
Message-Id: <1036959074.1009.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-10 at 19:04, J.E.J. Bottomley wrote:
> > The compile-time warning is _plenty_ good enough. 
> 
> I don't necessarily agree.  It's easy to miss in all the build noise (most 

Seconded - not only that people _keep_ removing the old entries without
fixing the bug - those bogon megaraid changes are far from unique


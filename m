Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbSLKSwL>; Wed, 11 Dec 2002 13:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbSLKSwL>; Wed, 11 Dec 2002 13:52:11 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:33731
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267277AbSLKSwK>; Wed, 11 Dec 2002 13:52:10 -0500
Subject: RE: 2.5 Changes doc update.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
Cc: "'Dave Jones'" <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <61DB42B180EAB34E9D28346C11535A7801130352@nocmail101.ma.tmpw.net>
References: <61DB42B180EAB34E9D28346C11535A7801130352@nocmail101.ma.tmpw.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 19:37:20 +0000
Message-Id: <1039635440.18412.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 17:38, Holzrichter, Bruce wrote:
> FWIW to you, though I know this is mostly x86 centric, there are Endian
> issues with current 2.5 IDE, and Big Endian machines such as sparc64 won't
> work right now with IDE.

I think sparc64 is currently the only broken platform like that. I've
got some bits from this nutter called Dave I'm merging bit by bit.
2.4.20-ac2 has the length fixes done.

Alan


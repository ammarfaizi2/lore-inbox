Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317864AbSHHSlS>; Thu, 8 Aug 2002 14:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317874AbSHHSlR>; Thu, 8 Aug 2002 14:41:17 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:36847 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317864AbSHHSkV>; Thu, 8 Aug 2002 14:40:21 -0400
Subject: Re: 2.4.19 BUG in page_alloc.c:91
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Anthony Russo., a.k.a. " Stupendous Man 
	<anthony.russo@verizon.net>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3D52B7D3.2000209@verizon.net>
References: <Pine.LNX.4.44L.0208072350060.23404-100000@imladris.surriel.com>	<3D51DD80.6
	 070501@verizon.net> <20020808075536.GB943@alpha.home.local>
	<3D529154.8090304@verizon.net>
	<1028835824.28882.57.camel@irongate.swansea.linux.org.uk> 
	<3D52B7D3.2000209@verizon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 08 Aug 2002 21:04:03 +0100
Message-Id: <1028837043.28883.75.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 19:26, Anthony Russo., a.k.a. Stupendous Man
wrote:
> It's a national semi chip ... the module name is natsemi.o,
> and indeed I am using it without incident now in place of fa312.o.
> 
> All of my modules are now GPL according to modinfo, so if the problem
> reoccurs now that I've rebooted we'll know if it's real.

Not only is it real, but I have every line of code on your box in front
of me if it does happen with that module. That helps no end in bug
hunting


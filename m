Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSINNVJ>; Sat, 14 Sep 2002 09:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSINNVJ>; Sat, 14 Sep 2002 09:21:09 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:4850 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316544AbSINNVJ>; Sat, 14 Sep 2002 09:21:09 -0400
Subject: Re: Linux client specweb test  hung
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hua Qin <qinhua@poisson.ecse.rpi.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10209140849340.11409-100000@poisson.ecse.rpi.edu>
References: <Pine.GSO.4.10.10209140849340.11409-100000@poisson.ecse.rpi.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 14 Sep 2002 14:27:01 +0100
Message-Id: <1032010021.12892.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-14 at 14:08, Hua Qin wrote:
> 
> Hi,
> 
> I think someone already have this discussion about this hung, but I did
> not see some solutions about. Here is my test case:
> 
> 1 Zeus web server: kernel 2.4.7-10
> 7 Specweb clients: kernel 2.2.16

2.4.17 is an old kernel with multiple errata fixes.
2.2.16 is obsolete, with known later networking, driver and other bugs
fixed.

Start with something current and see if you can duplicate the problem.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSHHSUl>; Thu, 8 Aug 2002 14:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317538AbSHHSUk>; Thu, 8 Aug 2002 14:20:40 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:28911 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317506AbSHHSUB>; Thu, 8 Aug 2002 14:20:01 -0400
Subject: Re: 2.4.19 BUG in page_alloc.c:91
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Anthony Russo., a.k.a. " Stupendous Man 
	<anthony.russo@verizon.net>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3D529154.8090304@verizon.net>
References: <Pine.LNX.4.44L.0208072350060.23404-100000@imladris.surriel.com>
	<3D51DD80.6070501@verizon.net> <20020808075536.GB943@alpha.home.local> 
	<3D529154.8090304@verizon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 08 Aug 2002 20:43:44 +0100
Message-Id: <1028835824.28882.57.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 16:42, Anthony Russo., a.k.a. Stupendous Man
wrote:
> AFAIK, the only proprietary module that is loaded is the fa312,
> which is a driver for my ethernet card,  which is still loaded
> and has never caused any problems for the 1.5 years I've used it.

You should be able to swap the fa312 driver for the matching open source
driver anyway. If I remember rightly isnt the 312 a realtek ?


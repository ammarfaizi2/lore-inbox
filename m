Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSHAUmR>; Thu, 1 Aug 2002 16:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSHAUmR>; Thu, 1 Aug 2002 16:42:17 -0400
Received: from p50887441.dip.t-dialin.net ([80.136.116.65]:42425 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317022AbSHAUmR>; Thu, 1 Aug 2002 16:42:17 -0400
Date: Thu, 1 Aug 2002 14:45:22 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Alexander Viro <viro@math.psu.edu>
cc: Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
       <Matt_Domsch@Dell.com>, <Andries.Brouwer@cwi.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.28 and partitions
In-Reply-To: <Pine.GSO.4.21.0208011610020.12627-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0208011440390.5119-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Aug 2002, Alexander Viro wrote:
> More powerful?

Well, compared to ASCII: it's unlikely that you meet a j letter or a \033 
in the size string.

I intended something such as GMP. We'd neet special maths functions for 
this crap then, of course, but it might be worth it. The basics is just 
"If field[n] overflows, push the overhead into field[n+1]"...

But you're of course right here that endianness is an issue here.

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-


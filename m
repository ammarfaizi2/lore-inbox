Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316039AbSFJUK3>; Mon, 10 Jun 2002 16:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316043AbSFJUK2>; Mon, 10 Jun 2002 16:10:28 -0400
Received: from p50887BDF.dip.t-dialin.net ([80.136.123.223]:38278 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316039AbSFJUK0>; Mon, 10 Jun 2002 16:10:26 -0400
Date: Mon, 10 Jun 2002 14:10:23 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Thunder from the hill <thunder@ngforever.de>
cc: Andrew Morton <akpm@zip.com.au>, Tom Rini <trini@kernel.crashing.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <Pine.LNX.4.44.0206101403010.6159-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0206101408380.6159-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Jun 2002, Thunder from the hill wrote:
> #define __FUNCTION__ __func__

Hmmm... that's just logical. If they just remove the __FUNCTION__ 
constant, there's nothing to complain about if we redefine it. Even my 
chaos brain sees that.

Regards,
Thunder
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere


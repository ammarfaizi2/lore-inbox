Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSFJOUO>; Mon, 10 Jun 2002 10:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315421AbSFJOSi>; Mon, 10 Jun 2002 10:18:38 -0400
Received: from p50887BDF.dip.t-dialin.net ([80.136.123.223]:54442 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315411AbSFJORk>; Mon, 10 Jun 2002 10:17:40 -0400
Date: Mon, 10 Jun 2002 08:17:40 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Mark Zealey <mark@zealos.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] introduce list_move macros
In-Reply-To: <20020609112316.GB744@itsolve.co.uk>
Message-ID: <Pine.LNX.4.44.0206100817080.6159-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Jun 2002, Mark Zealey wrote:
> I guess that should be:
> +#define list_move_tail(list,head) \
> 
> You should enclose the ops in a do { ... } while(0) block too.

There was a "revisited" version just a short time later. Please complain 
about that one ;-)

Regards,
Thunder
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere


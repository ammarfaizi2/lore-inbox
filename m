Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262233AbSIZHi5>; Thu, 26 Sep 2002 03:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262232AbSIZHi4>; Thu, 26 Sep 2002 03:38:56 -0400
Received: from merkur.ipht-jena.de ([194.94.32.22]:41942 "EHLO
	merkur.ipht-jena.de") by vger.kernel.org with ESMTP
	id <S262233AbSIZHiy>; Thu, 26 Sep 2002 03:38:54 -0400
Message-ID: <3D92BAB8.9090601@hh59.org>
Date: Thu, 26 Sep 2002 09:43:52 +0200
From: "Axel H. Siebenwirth" <axel@hh59.org>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.2b) Gecko/20020924
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre8
References: <Pine.LNX.4.44.0209252031350.15076-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

it would be very nice if you could, as Linus does, give a short rough 
outline about what has changed in the released kernel version. 
Just major and important changes because not everyone wants to read 
through all of it. Even in official kernel series many people would 
probably like to see such a short outline.

Best regards,
Axel Siebenwirth


Marcelo Tosatti wrote:

>So here goes -pre8.
>
>
>Summary of changes from v2.4.20-pre7 to v2.4.20-pre8
>============================================
>
><adam@nmt.edu>:
>  o 3ware driver update for 2.4.20-pre7 (resend)
>
><defouwj@purdue.edu>:
>  o net/ipv4/ip_options.c: IPOPT_END padding needs to increment optptr
>
><info@usblcd.de>:
>  o USBLCD updates
>
><kafai0928@yahoo.com>:
>  o Use SET_MODULE_OWNER in eepro100 net driver instead of MOD_{INC,DEC}_USE_COUNT, eliminating a small race
>  
>
....


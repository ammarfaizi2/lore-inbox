Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318807AbSG0TOt>; Sat, 27 Jul 2002 15:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318808AbSG0TOs>; Sat, 27 Jul 2002 15:14:48 -0400
Received: from flrtn-5-m1-95.vnnyca.adelphia.net ([24.55.70.95]:1162 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S318807AbSG0TOr>;
	Sat, 27 Jul 2002 15:14:47 -0400
Message-ID: <3D42F1DA.5060309@tmsusa.com>
Date: Sat, 27 Jul 2002 12:17:46 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020727
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: keep code simple
References: <200207270323.g6R3Nkb39182@saturn.cs.uml.edu> <200207271907.g6RJ7ST27551@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Denis Vlasenko wrote:

>On 27 July 2002 01:23, Albert D. Cahalan wrote:
>  
>
>>Remember that "optimized" code often runs slower than
>>simple code.
>>    
>>
>
>A bit offtopic, but: I heard M$ and Intel compilers beat GCC
>by 20-40% in terms of code size. Why GCC is so much behind?
>  
>
er...

one big reason is that gcc is cross platform, while
ms and intel can cut corners and optimize for x86

Just my $.02

Joe



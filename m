Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133074AbRDZD2l>; Wed, 25 Apr 2001 23:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133076AbRDZD2b>; Wed, 25 Apr 2001 23:28:31 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:61195 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S133074AbRDZD2M>; Wed, 25 Apr 2001 23:28:12 -0400
Date: Wed, 25 Apr 2001 22:48:10 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Feng Xian <fxian@fxian.jukie.net>
Cc: linux-kernel@vger.kernel.org, Feng Xian <fxian@chrysalis-its.com>
Subject: Re: __alloc_pages: 4-order allocation failed
In-Reply-To: <Pine.LNX.4.30.0104252059430.5253-100000@tiger>
Message-ID: <Pine.LNX.4.21.0104252247480.1088-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Apr 2001, Feng Xian wrote:

> Hi,
> 
> I am running linux-2.4.3 on a Dell dual PIII machine with 128M memory.
> After the machine runs a while, dmesg shows,
> 
> __alloc_pages: 4-order allocation failed.
> __alloc_pages: 3-order allocation failed.
> __alloc_pages: 4-order allocation failed.
> __alloc_pages: 4-order allocation failed.
> __alloc_pages: 4-order allocation failed.
> __alloc_pages: 4-order allocation failed.
> 
> 
> and sometime the system will crash. I looked into the memory info,
> there still has some free physical memory (20M) left and swap space is
> almost not in use. (250M swap)
> 
> I didn't have this problem when I ran 2.4.0 (I even didn't see it on
> 2.4.2) could anybody tell me what's wrong or where should I look into this
> problem?

Feng,

Which apps are you running when this happens ?

Thanks 



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbSLLQNd>; Thu, 12 Dec 2002 11:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbSLLQNd>; Thu, 12 Dec 2002 11:13:33 -0500
Received: from chaos.analogic.com ([204.178.40.224]:54149 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264702AbSLLQNc>; Thu, 12 Dec 2002 11:13:32 -0500
Date: Thu, 12 Dec 2002 11:23:29 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alexandre Pires <linux_kernel_br@yahoo.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Modules and dll
In-Reply-To: <03d501c2a1fe$7b371dd0$6400a8c0@sawamu>
Message-ID: <Pine.LNX.3.95.1021212112043.30483A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2002, Alexandre Pires wrote:

> Hi,
> 
>     We could compare the modules programs of linux with dlls of Windows ?
> Exist many differences between them (in relation to the functioning) ?
> 
> Thanks
> Alexandre R. Pires
> Brasil

They are completely different. The only thing in common is that they
exist as files. Under windows, DLL are like the run-time library files
you see in /lib and /usr/lib. They have something in common with
shared object files. Beyond that, they are very different.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281124AbRKEMz0>; Mon, 5 Nov 2001 07:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281125AbRKEMzG>; Mon, 5 Nov 2001 07:55:06 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:16324 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S281124AbRKEMzE>; Mon, 5 Nov 2001 07:55:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "MaxiM Basunov" <maxim@idknet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Page cache
Date: Mon, 5 Nov 2001 13:56:05 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <015001c165f4$c7f0fed0$05dda8c0@maxim>
In-Reply-To: <015001c165f4$c7f0fed0$05dda8c0@maxim>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011105125455Z17086-18972+109@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 5, 2001 01:24 pm, MaxiM Basunov wrote:
> Hello.
> 
> I have server with 1G RAM.
> And i want to run Oracle WITHOUT swapping it to disk...
> 
> how to reduce desires of a kernel about page cache?
> Mem:  1028692K av, 1023600K used,    5092K free, 678340K cached...
> 
> if i disable swap, linux runs kswapd with "load average 35"...
> 
> Kernel 2.4.9

Please try upgrading to kernel 2.4.13.

--
Daniel

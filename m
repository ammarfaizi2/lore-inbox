Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265660AbRF1MlV>; Thu, 28 Jun 2001 08:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265661AbRF1MlL>; Thu, 28 Jun 2001 08:41:11 -0400
Received: from butterblume.comunit.net ([192.76.134.57]:19474 "EHLO
	butterblume.comunit.net") by vger.kernel.org with ESMTP
	id <S265660AbRF1Mkw>; Thu, 28 Jun 2001 08:40:52 -0400
Date: Thu, 28 Jun 2001 14:40:48 +0200 (CEST)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: <haegar@space.comunit.de>
To: Rodrigo Ventura <yoda@isr.ist.utl.pt>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: iwconfig seg-faults
In-Reply-To: <lx3d8kx2gz.fsf@pixie.isr.ist.utl.pt>
Message-ID: <Pine.LNX.4.33.0106281439060.12529-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jun 2001, Rodrigo Ventura wrote:

>         SuSE 7.1, wireless-tools-20-5, kernel 2.4.5-pre3:
>
> /root# gdb iwconfig
> [...]
> (gdb) run wvlan0
[...]

> Program received signal SIGSEGV, Segmentation fault.
> 0xc22ab05c in ?? ()
>
>         Can't get any further useful info from gdb.
>
>         Is this a known "issue"?

Got the same problem with Debian unstable (sid), Kernel 2.4.5-ac8 and a
Orinoco 11mbit-Card (Toshiba Sattelite Pro 4600 build in - MiniPCI?)

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)


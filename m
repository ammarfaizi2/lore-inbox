Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270102AbRHXJ3j>; Fri, 24 Aug 2001 05:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271006AbRHXJ3a>; Fri, 24 Aug 2001 05:29:30 -0400
Received: from maila.telia.com ([194.22.194.231]:30665 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S270102AbRHXJ3Q>;
	Fri, 24 Aug 2001 05:29:16 -0400
Date: Fri, 24 Aug 2001 11:28:37 +0200
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: python now required for kernel compile -- <grin>
Message-ID: <20010824112837.A2779@telia.com>
Mail-Followup-To: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1010823083600.5631A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.3.95.1010823083600.5631A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson <root@chaos.analogic.com> wrote:

> Python 1.3 (Mar 11 1996)  [GCC 2.7.2]
> Copyright 1991-1995 Stichting Mathematisch Centrum, Amsterdam
> >>> ^C 
> KeyboardInterrupt
> >>> ^C 
> KeyboardInterrupt
> >>> ^C 
> KeyboardInterrupt
> >>> help
> >Traceback (innermost last):
>   File "<stdin>", line 1, in ?
> NameError: help
> >>> quit
> >Traceback (innermost last):
>   File "<stdin>", line 1, in ?
> NameError: quit

With python2 (which is required for CML2):

andre@sledgehammer:~$ python2
Python 2.0.1 (#0, Jun 23 2001, 23:50:30) 
[GCC 2.95.4 20010319 (Debian prerelease)] on linux2
Type "copyright", "credits" or "license" for more information.
>>> quit
'Use Ctrl-D (i.e. EOF) to exit.'
>>> exit
'Use Ctrl-D (i.e. EOF) to exit.'
-- 

André Dahlqvist <andre.dahlqvist@telia.com>

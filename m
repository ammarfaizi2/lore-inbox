Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbSK2OQw>; Fri, 29 Nov 2002 09:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267062AbSK2OQw>; Fri, 29 Nov 2002 09:16:52 -0500
Received: from mail.hamburg.pop.de ([193.98.9.7]:32430 "EHLO mail.provi.de")
	by vger.kernel.org with ESMTP id <S267052AbSK2OQv>;
	Fri, 29 Nov 2002 09:16:51 -0500
Message-Id: <3DE7788C.9581239E@gmx.de>
Date: Fri, 29 Nov 2002 15:24:12 +0100
From: Bernd Harries <bha@gmx.de>
Reply-To: bha@gmx.de
Organization: STN ATLAS Elektronik GmbH
X-Mailer: Mozilla 4.72 [en] (X11; I; OSF1 V4.0 alpha)
X-Accept-Language: en
Mime-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ioremap returns NULL
References: <3DE774AC.6E371602@gmx.de> <200211291514.50171.gabrielli@roma2.infn.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What could I do about it?
> - Build a 64 GB kernel?

> build kernel with Himem (4Gb)

Oh, I forgot to write that the Kernel (Red Hat 7.3 with
2.14.18-3smp_custom has the 4G flag enabled..

What seems to happen is that the  vitual  kernel address space gets too
small.(?)

Thanks, Bernd

-- 
Bernd Harries

bha@gmx.de
bharries@web.de       Tel. +49 421 809 7343 priv.  | MSB First!
harries@stn-atlas.de       +49 421 457 3966 offi.  | Linux-m68k
bernd@linux-m68k.org       +49 172 139 6054 handy  | Medusa T40

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314321AbSEMRKH>; Mon, 13 May 2002 13:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314274AbSEMRKG>; Mon, 13 May 2002 13:10:06 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:16903 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S314321AbSEMRKF>; Mon, 13 May 2002 13:10:05 -0400
Message-Id: <200205131709.g4DH9Fjv006328@pincoya.inf.utfsm.cl>
To: Elladan <elladan@eskimo.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed 
In-Reply-To: Message from Elladan <elladan@eskimo.com> 
   of "Sun, 12 May 2002 11:37:30 MST." <20020512113730.A24085@eskimo.com> 
Date: Mon, 13 May 2002 13:09:15 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elladan <elladan@eskimo.com> said:

[...]

> Regardless of whether it's a good thing to depend on security-wise, it
> is a problem to have something that appears to be a security feature
> which doesn't actually work.

It is _not_ a security feature, it is meant to keep the filesystem from
fragmenting too badly. root can use that space, since root can do whatever
she wants anyway.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

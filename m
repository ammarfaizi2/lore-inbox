Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280792AbRKGOW2>; Wed, 7 Nov 2001 09:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280799AbRKGOWT>; Wed, 7 Nov 2001 09:22:19 -0500
Received: from full215.sara.unitn.it ([193.205.210.215]:56562 "EHLO
	dizzy.dz.net") by vger.kernel.org with ESMTP id <S280792AbRKGOWI>;
	Wed, 7 Nov 2001 09:22:08 -0500
From: Massimo Dal Zotto <dz@cs.unitn.it>
Message-Id: <200111071421.fA7ELjYM015008@dizzy.dz.net>
Subject: Re: [PATCH] SMM BIOS on Dell i8100
In-Reply-To: <20011107111339.A4155@emeraude.kwisatz.net> "from Stephane Jourdois
 at Nov 7, 2001 11:13:39 am"
To: stephane@tuxfinder.org
Date: Wed, 7 Nov 2001 15:21:44 +0100 (MET)
CC: Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Yup I did that on i8kutils-1.1, then reverted to system(), because I
> removed the anti-repeat system, and used a slow mixer application. Then
> the repeat was bad (sometimes slow, sometimes quick).
> In fact, I don't really mind, as now I use aumix (and it is fast
> enought).
> 
> Massimo, choose one please :-)
> 
>         Stephane
> 

I have released version 1.3 of the package. It includes the autorepeat
feature and solves the zombie problem. You can download it from:

  http://www.debian.org/~dz/i8k/

There is also a new smm-test script which can be used to test the SMM bios
on Inspiron laptops. This command can be very dangerous, use with caution!

-- 
Massimo Dal Zotto

+----------------------------------------------------------------------+
|  Massimo Dal Zotto               email: massimo.dalzotto@libero.it   |
|  Via Marconi, 141                phone: ++39-461534251               |
|  38057 Pergine Valsugana (TN)      www: http://www.cs.unitn.it/~dz/  |
|  Italy                                  http://www.debian.org/~dz/   |
|  gpg:   2DB65596  3CED BDC6 4F23 BEDA F489 2445 147F 1AEA 2DB6 5596  |
+----------------------------------------------------------------------+

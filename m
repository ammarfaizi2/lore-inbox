Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSLTOUZ>; Fri, 20 Dec 2002 09:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbSLTOUZ>; Fri, 20 Dec 2002 09:20:25 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:15877 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S262215AbSLTOUY>; Fri, 20 Dec 2002 09:20:24 -0500
Message-Id: <200212201427.gBKERHxY007808@pincoya.inf.utfsm.cl>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Are working modules going to be in 2.6? 
In-reply-to: Your message of "Thu, 19 Dec 2002 15:58:11 CDT."
             <Pine.LNX.3.96.1021219154713.29567A-100000@gatekeeper.tmr.com> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Fri, 20 Dec 2002 11:27:17 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> said:
> I have downloaded any number of modutil this and init-mod that, built them
> static, rolled my own initrd files, and as far as I can tell it just
> doesn't work with 2.5.48+.

Strange. My setup works fine with initrd, modutils from Rusty and 2.5.50 at
least. I had to redo the mkinitrd step for it to work under RH 8.0, but
that was it.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274233AbRIXXHP>; Mon, 24 Sep 2001 19:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274234AbRIXXHF>; Mon, 24 Sep 2001 19:07:05 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:7429 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S274233AbRIXXGw>; Mon, 24 Sep 2001 19:06:52 -0400
Message-Id: <200109242307.f8ON7A0i025305@pincoya.inf.utfsm.cl>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: 2.4.9-ac15: Missing symbols in kernel.o:apm()
X-Mailer: MH [Version 6.8.4]
Date: Mon, 24 Sep 2001 19:07:10 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It complains about missing __sysrq_{{,un}lock_table,{get,put}_key} in
arch/i386/kernel.o function apm on linking.

Same configuration worked fine with -ac14 and earlier.
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

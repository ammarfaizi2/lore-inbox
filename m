Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132587AbRACRVM>; Wed, 3 Jan 2001 12:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132601AbRACRVC>; Wed, 3 Jan 2001 12:21:02 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:35090 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S132587AbRACRUt>; Wed, 3 Jan 2001 12:20:49 -0500
Message-Id: <200101031650.f03Go4D29320@pincoya.inf.utfsm.cl>
To: linux-kernel@vger.kernel.org
cc: David Miller <davem@redhat.com>
Subject: 2.2.19pre5 on sparc64: Missing symbols
X-Mailer: MH [Version 6.8.4]
Date: Wed, 03 Jan 2001 13:50:04 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SS U1, RH 6.2 + updates

depmod: *** Unresolved symbols in /lib/modules/2.2.19pre5/fs/binfmt_elf.o
depmod: 	get_pte_slow
depmod: 	get_pmd_slow
depmod: 	pgt_quicklists
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

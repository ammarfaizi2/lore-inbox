Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262498AbSJAR1c>; Tue, 1 Oct 2002 13:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262502AbSJAR1W>; Tue, 1 Oct 2002 13:27:22 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:13321 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S262498AbSJAR06>; Tue, 1 Oct 2002 13:26:58 -0400
Message-Id: <200210011732.g91HWAFg005992@pincoya.inf.utfsm.cl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 modules don't load under RH 7.3?
X-Mailer: MH [Version 6.8.4]
Date: Tue, 01 Oct 2002 13:32:10 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiled UP 2.5.40 i686 yesterday, no initrd (doesn't work as of 2.5.38 or
so). Boots fine, mounts filesystems (ext3 builtin, ext2 not there at all,
else it won't mount anything... should perhaps consider ext3 first and ext2
next?). But no modules can get loaded.

Does this need new modutils (or perhaps something else?). Haven't followed
the modules discussion too closely, sorry.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

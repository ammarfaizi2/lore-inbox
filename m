Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSI2X7U>; Sun, 29 Sep 2002 19:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261845AbSI2X57>; Sun, 29 Sep 2002 19:57:59 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:9491 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S261848AbSI2X5K>; Sun, 29 Sep 2002 19:57:10 -0400
Date: Sun, 29 Sep 2002 20:02:25 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Message-Id: <200209300002.g8U02Pis024933@pincoya.inf.utfsm.cl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.39-bk current compile failure
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/ksyms.c is missing declarations for tvec_bases, bh_task_vec, init_bh,
remove_bh, __run_task_queue

In the middle of a big update?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

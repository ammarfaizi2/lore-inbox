Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264618AbSIVXmm>; Sun, 22 Sep 2002 19:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264619AbSIVXmm>; Sun, 22 Sep 2002 19:42:42 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:62481 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S264618AbSIVXmm>; Sun, 22 Sep 2002 19:42:42 -0400
Message-Id: <200209222347.g8MNloWP004456@pincoya.inf.utfsm.cl>
To: Marcelo Tossati <marcelo@plucky.distro.conectiva>
cc: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre7 (BK from today)
X-Mailer: MH [Version 6.8.4]
Date: Sun, 22 Sep 2002 19:47:49 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/ipv4/netfilter/ip_conntrack_proto_tcp.c needs

 #include <linux/string.h>
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

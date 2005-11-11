Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVKLMYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVKLMYg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 07:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVKLMYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 07:24:36 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:15784 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S932372AbVKLMYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 07:24:36 -0500
Message-Id: <200511111336.jABDajMd019962@pincoya.inf.utfsm.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Breakage in net/ipv4/tcp_vegas.c
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 11 Nov 2005 10:36:45 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC [M]  net/ipv4/tcp_vegas.o
net/ipv4/tcp_vegas.c: In function ‘tcp_vegas_cong_avoid’:
net/ipv4/tcp_vegas.c:239: error: ‘cnt’ undeclared (first use in this function)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

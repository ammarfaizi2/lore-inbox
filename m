Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272056AbTGYNGF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 09:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272058AbTGYNGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 09:06:05 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:51095 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S272056AbTGYNFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 09:05:39 -0400
Date: Fri, 25 Jul 2003 10:17:11 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andrew Morton <akpm@digeo.com>, bcrl@redhat.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Kconfig still mentions sys_hugepages syscalls
Message-ID: <Pine.LNX.4.55L.0307251014280.12492@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

2.6.0-test1-bk2 Kconfig still mentions sys_hugepages syscalls which is
wrong.

I might send a patch later (I'm configuring 2.6.0-test1-bk2 to stress it
on a 8way OSDL box now).

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318650AbSHAHZo>; Thu, 1 Aug 2002 03:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318652AbSHAHZo>; Thu, 1 Aug 2002 03:25:44 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:25863 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318650AbSHAHZn>; Thu, 1 Aug 2002 03:25:43 -0400
Date: Thu, 1 Aug 2002 03:38:23 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux v2.4.19-rc5
Message-ID: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One of the -rc4 fixes was not correct and -rc4 missed an important SMP
race "fix" on the block layer.


Summary of changes from v2.4.19-rc4 to v2.4.19-rc5
============================================

<davem@redhat.com> (02/08/01 1.662)
	[PATCH] Correct openprom fix

	   <davem@redhat.com> (02/07/31 1.661)
	   	[PATCH] Add missing check to openprom driver

<akpm@zip.com.au> (02/08/01 1.663)
	[PATCH] disable READA

<marcelo@plucky.distro.conectiva> (02/08/01 1.664)
	Change EXTRAVERSION to -rc5


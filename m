Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTHYA6Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 20:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTHYA6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 20:58:25 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:24778 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261176AbTHYA6Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 20:58:24 -0400
Date: Sun, 24 Aug 2003 21:54:13 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.22-rc4
Message-ID: <Pine.LNX.4.55L.0308242151340.28519@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

A few annoying things showed up, so here goes -rc4.


Summary of changes from v2.4.22-rc3 to v2.4.22-rc4
============================================

<marcelo:logos.cnet>:
  o Fix drivers/net/Config.in -> CONFIG_TC35815
  o Changed EXTRAVERSION to -rc4

Andi Kleen:
  o Fix x86-64 ia32 emulation

Paul Mackerras:
  o PPC32: Make strncpy clear the unused part of the destination
  o PPC32: Make sure various sections get aligned properly by the linker

Ralf Bächle:
  o dep_tristate fix for CONFIG_TC35815


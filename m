Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269918AbTGKMXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 08:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269915AbTGKMXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 08:23:50 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:33709 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S269914AbTGKMXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 08:23:48 -0400
Date: Fri, 11 Jul 2003 14:38:29 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-net@vger.kernel.org
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: IPV6 warnings in 2.4.22-pre4
Message-ID: <Pine.GSO.4.21.0307111434400.8989-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When compiling 2.4.22-pre4 for m68k, I see these suspicious warnings:

| ip6t_rt.c:134: warning: assignment from incompatible pointer type
| ip6t_ipv6header.c:43: warning: unused variable `opt'
| ip6t_frag.c:151: warning: assignment from incompatible pointer type
| ip6t_esp.c:127: warning: assignment from incompatible pointer type
| ip6t_ah.c:137: warning: assignment from incompatible pointer type

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


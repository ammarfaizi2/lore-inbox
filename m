Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTH2Vt7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 17:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbTH2Vtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 17:49:55 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:41442 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262296AbTH2Vtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 17:49:52 -0400
Date: Fri, 29 Aug 2003 23:49:01 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix the -test3 input config damages
In-Reply-To: <Pine.GSO.4.21.0308261030510.615-100000@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.21.0308292348010.4027-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BTW, what about adding a `suggests' keyword to Kconfig, cfr. Debian package
dependencies?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


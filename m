Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277082AbRKDBNT>; Sat, 3 Nov 2001 20:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277119AbRKDBNI>; Sat, 3 Nov 2001 20:13:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10258 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277082AbRKDBMx>; Sat, 3 Nov 2001 20:12:53 -0500
Subject: Re: [khttpd-users] khttpd vs tux
To: jjs@pobox.com (J Sloan)
Date: Sun, 4 Nov 2001 01:19:18 +0000 (GMT)
Cc: roy@karlsbakk.net (Roy Sigurd Karlsbakk),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        tlussnig@bewegungsmelder.de (Thomas Lussnig),
        linux-kernel@vger.kernel.org,
        khttpd-users@zgp.org (khttpd mailing list),
        tux-list@redhat.com (Tux mailing list)
In-Reply-To: <3BE4460F.97FAD9CE@pobox.com> from "J Sloan" at Nov 03, 2001 11:31:27 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E160BwU-0007NN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nobody scales better 1-4 CPUs, as indicated
> by specweb99 - at 8 CPUs linux is OK, but not
> as dominating....

At specweb. For some 2 and a large number of 4 processor workloads our
scheduler does not make good decisions

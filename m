Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279768AbRL1QZq>; Fri, 28 Dec 2001 11:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281835AbRL1QZg>; Fri, 28 Dec 2001 11:25:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37641 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279768AbRL1QZX>; Fri, 28 Dec 2001 11:25:23 -0500
Subject: Re: State of the new config & build system
To: kaos@ocs.com.au (Keith Owens)
Date: Fri, 28 Dec 2001 16:34:43 +0000 (GMT)
Cc: garzik@havoc.gtf.org (Legacy Fishtank), davej@suse.de (Dave Jones),
        esr@snark.thyrsus.com (Eric S. Raymond),
        torvalds@transmeta.com (Linus Torvalds),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <2705.1009532564@ocs3.intra.ocs.com.au> from "Keith Owens" at Dec 28, 2001 08:42:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Jzxz-0000yu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> including if you build on one system then try to install via NFS on a
> second system.  kbuild 2.5 can cope with trees being renamed and trees
> having different names on local and NFS mounted systems.  That
> flexibility comes at a cost.

So you've halved performance rather than documented that you have to mount
the tree in the space place on every NFS export ? I'm obviously still
missing something here.

Alan

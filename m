Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283545AbRLDWLx>; Tue, 4 Dec 2001 17:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283540AbRLDWLn>; Tue, 4 Dec 2001 17:11:43 -0500
Received: from h24-80-196-159.gv.shawcable.net ([24.80.196.159]:34564 "EHLO
	trevor.house-net.ca") by vger.kernel.org with ESMTP
	id <S283556AbRLDWL2>; Tue, 4 Dec 2001 17:11:28 -0500
Message-ID: <007801c17d10$8a21bc60$0a49a8c0@dagate.trevor>
From: "Trevor Smith" <trevorlsmith@home.com>
To: "Edward Muller" <emuller@learningpatterns.com>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Dave Jones" <davej@suse.de>, "Eric S. Raymond" <esr@thyrsus.com>,
        <linux-kernel@vger.kernel.org>, "Christoph Hellwig" <hch@caldera.de>,
        "Keith Owens" <kaos@ocs.com.au>, <kbuild-devel@lists.sourceforge.net>,
        <torvalds@transmeta.com>
In-Reply-To: <E16BM38-0003K1-00@the-village.bc.nu>
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Date: Tue, 4 Dec 2001 14:10:04 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That's been the case all along, sans python2. Newer kernels need newer
> > tools. That's always been the case.
>
> Not during stable releases. In fact we've jumped through hoops several
times
> to try and keep egcs built kernels working

Are we not talking about the 2.5 kernel build tree? My understanding of the
numbering of kernels is that the 2.4.x tree is stable; and the 2.5.x tree is
the new development tree

If the suggestion was to alter the 2.4 tree in a way that required
additional tools; I could understand the concern; the 2.5 tree is unstable;
and so to go from 2.5.a to 2.5.b I expect to have to be really carefull and
*READ* the release notes; similarly from 2.2.x to 2.4.x; but 2.4.a to 2.4.b
I generally detar the tree; copy my .config over check with menuconfig that
things make sense; build the kernel and expect things to work; release notes
you ask? ..I only glance at them to see if anything strikes my eye; but they
are not read completely

Trevor


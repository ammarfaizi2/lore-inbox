Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282910AbRLDUOa>; Tue, 4 Dec 2001 15:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283411AbRLDUNG>; Tue, 4 Dec 2001 15:13:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38150 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283388AbRLDUMK>; Tue, 4 Dec 2001 15:12:10 -0500
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
To: emuller@learningpatterns.com (Edward Muller)
Date: Tue, 4 Dec 2001 20:20:18 +0000 (GMT)
Cc: davej@suse.de (Dave Jones), esr@thyrsus.com (Eric S. Raymond),
        linux-kernel@vger.kernel.org, hch@caldera.de (Christoph Hellwig),
        kaos@ocs.com.au (Keith Owens), kbuild-devel@lists.sourceforge.net,
        torvalds@transmeta.com
In-Reply-To: <1007495969.4621.9.camel@akira.learningpatterns.com> from "Edward Muller" at Dec 04, 2001 02:59:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BM38-0003K1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So anyone perfectly happy with an older distro that didn't
> > ship python2-and-whatever-else gets screwed when they want to
> > build a newer kernel. Nice.
> 
> That's been the case all along, sans python2. Newer kernels need newer
> tools. That's always been the case.

Not during stable releases. In fact we've jumped through hoops several times
to try and keep egcs built kernels working

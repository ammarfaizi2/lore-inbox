Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279032AbRJVWrN>; Mon, 22 Oct 2001 18:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279029AbRJVWpd>; Mon, 22 Oct 2001 18:45:33 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12305 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279034AbRJVWpA>; Mon, 22 Oct 2001 18:45:00 -0400
Subject: Re: hfs cdrom broken in 2.4.13pre
To: hollis-lists@austin.rr.com (Hollis Blanchard)
Date: Mon, 22 Oct 2001 23:51:51 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        pochini@denise.shiny.it (Giuliano Pochini),
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <B7FA0929.12F5%hollis-lists@austin.rr.com> from "Hollis Blanchard" at Oct 22, 2001 05:34:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vnvD-0003jl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> on 22/10/01 4:44 PM, Alan Cox at alan@lxorguk.ukuu.org.uk wrote:
> > 
> >> Kernel 2.4.13pre1 on powerpc. I can no longer mount HFS-formatted cdroms.
> >> The last kernel I'm sure it worked fine is 2.4.7
> > 
> > Mount it over loopback device.
> 
> Why has that become necessary?

Primarily because the glue in the middle isnt covering up for your CD-ROM
any more.

Alan

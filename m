Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270264AbRHMP6s>; Mon, 13 Aug 2001 11:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270268AbRHMP6j>; Mon, 13 Aug 2001 11:58:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36358 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270264AbRHMP6W>; Mon, 13 Aug 2001 11:58:22 -0400
Subject: Re: S2464 (K7 Thunder) hangs -- some lessons learned
To: esr@thyrsus.com
Date: Mon, 13 Aug 2001 17:00:54 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20010813115214.A23591@thyrsus.com> from "Eric S. Raymond" at Aug 13, 2001 11:52:14 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WK98-0007gd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > You need to look at the lspci hex data. There's an errata document for the
> > MP chipset on www.amd.com if you realyl want to scare yourself 8)
> 
> Is there a more formal name for the chipset than just "760"?

http://www.amd.com/products/cpg/athlon/techdocs/index.html#chipset

Its the AMD760tm MP - really

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262275AbRERIZy>; Fri, 18 May 2001 04:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262276AbRERIZo>; Fri, 18 May 2001 04:25:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63242 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262275AbRERIZe>; Fri, 18 May 2001 04:25:34 -0400
Subject: Re: CML2 design philosophy heads-up
To: esr@thyrsus.com
Date: Fri, 18 May 2001 09:20:47 +0100 (BST)
Cc: trini@kernel.crashing.org (Tom Rini),
        meissner@spectacle-pond.org (Michael Meissner),
        kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010518034307.A10784@thyrsus.com> from "Eric S. Raymond" at May 18, 2001 03:43:07 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150fV9-0006q1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Both of these 'problems' assume that you can have IDE or PCMCIA on these
> > particular boxes.  Does anyone know if that's actually true?
> 
> The answer is: no, you can't.  
> 
> I found a feature list for the MVME147 on the web at
> <http://www.mcg.mot.com/cfm/templates/article.cfm?PageID=1095>.  It
> confirmed what thought I remembered from the Motorola site; no PCMCIA,
> no IDE/ATAPI.  As a matter of fact neither of these technologies
> existed yet when the board was being designed in the mid-1980s.

I was under the impression the MVME had VME bus. So you can hang IDE off it
and other gunge. Its also a reference design so you may find MVME147 like
boards..

Alan


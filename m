Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbRERR26>; Fri, 18 May 2001 13:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261255AbRERR2s>; Fri, 18 May 2001 13:28:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23310 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261246AbRERR2j>; Fri, 18 May 2001 13:28:39 -0400
Subject: Re: CML2 design philosophy heads-up
To: esr@thyrsus.com
Date: Fri, 18 May 2001 18:23:55 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), trini@kernel.crashing.org (Tom Rini),
        meissner@spectacle-pond.org (Michael Meissner),
        kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010518120434.F14309@thyrsus.com> from "Eric S. Raymond" at May 18, 2001 12:04:34 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150nyl-0007Ot-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want to understand what you're driving at here and I don't get it.  What's

What I am trying to say is that if you can infer probable configuration
categories that are relevant then instead of automatically filling the other
areas in and blocking changing them without using vi you can put the other
options as a submenu. That guides the less expert user and also helps rather
than hinders the expert


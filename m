Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268971AbRHBP2A>; Thu, 2 Aug 2001 11:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269038AbRHBP1u>; Thu, 2 Aug 2001 11:27:50 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37906 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269029AbRHBP1p>; Thu, 2 Aug 2001 11:27:45 -0400
Subject: Re: OT: Virii on vger.kernel.org lists
To: rogers@ISI.EDU (Craig Milo Rogers)
Date: Thu, 2 Aug 2001 16:27:19 +0100 (BST)
Cc: rhw@MemAlpha.CX (Riley Williams), matti.aarnio@zmailer.org (Matti Aarnio),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <1661.996618791@ISI.EDU> from "Craig Milo Rogers" at Jul 31, 2001 03:33:11 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SKNb-0000sp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Two problems with that:
> > 1. Some virii are text attachments. Your fix doesn't deal wioth them.
> 
> 	I'm not aware of the TEXT/PLAIN viruses (ignoring jokes, er,
> social comments, about the GPL).  Could you point me to a sample?

Mime header based ones: there have been several
Body text based ones: I know of one that exploited the escape vulnerability
in X11R5 xterm - it really was a 'README' virus.

Alan

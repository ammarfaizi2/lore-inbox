Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262349AbRERPnn>; Fri, 18 May 2001 11:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262350AbRERPnd>; Fri, 18 May 2001 11:43:33 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19725 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262349AbRERPnW>; Fri, 18 May 2001 11:43:22 -0400
Subject: Re: CML2 design philosophy heads-up
To: kaos@ocs.com.au (Keith Owens)
Date: Fri, 18 May 2001 16:39:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (CML2), kbuild-devel@lists.sourceforge.net
In-Reply-To: <1694.990198581@ocs3.ocs-net> from "Keith Owens" at May 19, 2001 01:09:41 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150mM9-0007Fg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   (c) Decide not to support this case and document the fact in the
> >       rulesfile.  If you're going put gunge on the VME bus that replaces
> >       the SBC's on-board facilities, you can hand-hack your own configs.
> 
> In general this is the best option, if you create a non-standard
> configuration for machine foo then it is your problem, not everybody
> else's.

Which makes CML2 inferior to CML1 again. Now if it could parse CML1 rulesets
this whole discussion wouldn't be needed. 

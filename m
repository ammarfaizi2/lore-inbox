Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268057AbUIKAhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268057AbUIKAhX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 20:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268059AbUIKAhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 20:37:23 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:5080 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268056AbUIKAhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 20:37:04 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Subject: Re: [PATCH] sis5513 fix for SiS962 chipset
Date: Fri, 10 Sep 2004 23:21:16 +0200
User-Agent: KMail/1.6.2
Cc: tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
       Linux-IDE <linux-ide@vger.kernel.org>
References: <1094826555.7868.186.camel@thomas.tec.linutronix.de> <1094828803.13450.4.camel@thomas.tec.linutronix.de> <4141C8C6.1030307@inet6.fr>
In-Reply-To: <4141C8C6.1030307@inet6.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409102321.17042.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 September 2004 17:31, Lionel Bouton wrote:
> Thomas Gleixner wrote the following on 09/10/2004 05:06 PM :
> 
> >On Fri, 2004-09-10 at 16:53, Lionel Bouton wrote:
> >  
> >
> >> [...]
> >>
> >> What hardware did you use to test ?
> >>    
> >>
> >
> >Compact PCI ICP-P4 from Inova Computers.
> >
> >  
> >
> 
> I see it's not really a cutting-edge design (2002). Apparently nobody 
> seemed to care about Linux IDE performance before :-|

Yep. :/  Lionel, can I push this fix upstream?

Could somebody enlighten me what exactly 'remapping mode' does?

Bartlomiej

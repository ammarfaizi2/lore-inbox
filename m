Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbTH0QlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTH0QlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:41:13 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:41694 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S263586AbTH0QlM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:41:12 -0400
Date: Wed, 27 Aug 2003 18:41:10 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mlord@pobox.com,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 2.6][TRIVIAL] Update ide.txt documentation to current
 ide.c
In-Reply-To: <1061998172.22825.51.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.51.0308271839110.32333@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0308211225120.23765@dns.toxicfilms.tv>
 <1061998172.22825.51.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   "hdx=slow"		: insert a huge pause after each access to the data
> >  			  port. Should be used only as a last resort.
>
> Should go - isnt supported any more
So drivers/ide/ide.c should be updated too.

> > + "ide=reverse"		: formerly called to pci sub-system, but now local.
> > +
>
> Better if it said what it did ?
drivers/ide/ide.c says only this.

Maciej

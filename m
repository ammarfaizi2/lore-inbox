Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbTIEQn6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 12:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTIEQn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 12:43:58 -0400
Received: from palrel13.hp.com ([156.153.255.238]:3216 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263229AbTIEQn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 12:43:57 -0400
Date: Fri, 5 Sep 2003 09:43:33 -0700
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] Wireless Extension v16 : 802.11a/802.11g fixes
Message-ID: <20030905164333.GA12481@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030904174413.GA5094@bougret.hpl.hp.com> <Pine.LNX.4.44.0309050928270.2601-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309050928270.2601-100000@logos.cnet>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 09:29:10AM -0300, Marcelo Tosatti wrote:
> 
> 
> On Thu, 4 Sep 2003, Jean Tourrilhes wrote:
> 
> >         Hi Marcelo,
> > 
> > 	I really need this patch to go in 2.4.23, as many wireless
> > drivers need it (airo.c + various external drivers). This is super
> > safe as many people have tested it in 2.5.X and downloaded from my web
> > page.
> > 	Resend (see below), retested for 2.4.23-pre3.
> > 	Changelog :
> > 	o add more 802.11a/802.11g support (more freq/bitrates)
> > 	o improved iwspy support (used by airo.c)
> > 
> 
> Its in the repository already:
> 
> http://linux.bkbits.net:8080/linux-2.4/cset@1.1144?nav=index.html|ChangeSet@-3d

	Sorry. I looked there, but for some reason it wasn't updated.
	Thanks a lot !

	Jean


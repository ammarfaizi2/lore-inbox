Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbSLKBOy>; Tue, 10 Dec 2002 20:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbSLKBOy>; Tue, 10 Dec 2002 20:14:54 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:23528 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266938AbSLKBOx>;
	Tue, 10 Dec 2002 20:14:53 -0500
Date: Tue, 10 Dec 2002 17:22:36 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Alessandro Suardi <alessandro.suardi@oracle.com>
Subject: Re: module-init-tools 0.9.3 -- "missing" issue
Message-ID: <20021211012236.GB5853@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote :
> In message <3DF67878.6090703@oracle.com> you write:
> >   to modprobe vfat - but not the full irda stack, I'll report this
> >   separately to Jean) _and_ on 2.4.20 (modular IrDA and PPP are
> 
> I'd appreciate receiving a copy of that irda report.  It's probably
> not Jean's fault.

	I've just managed to load and run Linux-IrDA on 2.5.51, and
apart from a few warning (see my other e-mail) it was working. I even
tested PPP over IrCOMM. But I didn't check smc-ircc.
	So, this one might be *mine* ;-)

	Have fun...

	Jean

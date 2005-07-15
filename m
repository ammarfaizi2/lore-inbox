Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263300AbVGOL3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbVGOL3Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 07:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVGOL1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 07:27:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21920 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261612AbVGOLZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 07:25:29 -0400
Subject: Re: Buffer Over-runs, was Open source firewalls
From: Arjan van de Ven <arjan@infradead.org>
To: rvk@prodmail.net
Cc: omb@bluewin.ch, linux-kernel@vger.kernel.org
In-Reply-To: <42D79B3D.7080108@prodmail.net>
References: <20050713163424.35416.qmail@web32110.mail.mud.yahoo.com>
	 <42D63AD0.6060609@aitel.hist.no> <42D63D4A.2050607@prodmail.net>
	 <42D658A8.4040009@aitel.hist.no> <42D658A9.7050706@prodmail.net>
	 <42D6ECED.7070504@khandalf.com>  <42D75A93.5010904@prodmail.net>
	 <1121410260.3179.3.camel@laptopd505.fenrus.org>
	 <42D7734D.9070204@prodmail.net>
	 <1121417215.3179.7.camel@laptopd505.fenrus.org>
	 <42D79B3D.7080108@prodmail.net>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 13:24:57 +0200
Message-Id: <1121426697.3179.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 16:47 +0530, RVK wrote:
> Arjan van de Ven wrote:
> >so it's new? so what? doesn't make it less true that it nowadays is a
> >lot harder to exploit such bugs on recent distros.
> >
> >  
> >
> How about using ProPolice etc ?

that's also a good one; gcc 4.1 will have a propolice port included
already. So I suspect all future distros will have this (once they make
the jump to 4.1 or when they backport this)
> 
> rvk
> 
> >.
> >
> >  
> >
> 


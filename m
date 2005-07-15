Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263247AbVGOIr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263247AbVGOIr3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 04:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbVGOIr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 04:47:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29110 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263247AbVGOIr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 04:47:27 -0400
Subject: Re: Buffer Over-runs, was Open source firewalls
From: Arjan van de Ven <arjan@infradead.org>
To: rvk@prodmail.net
Cc: omb@bluewin.ch, linux-kernel@vger.kernel.org
In-Reply-To: <42D7734D.9070204@prodmail.net>
References: <20050713163424.35416.qmail@web32110.mail.mud.yahoo.com>
	 <42D63AD0.6060609@aitel.hist.no> <42D63D4A.2050607@prodmail.net>
	 <42D658A8.4040009@aitel.hist.no> <42D658A9.7050706@prodmail.net>
	 <42D6ECED.7070504@khandalf.com>  <42D75A93.5010904@prodmail.net>
	 <1121410260.3179.3.camel@laptopd505.fenrus.org>
	 <42D7734D.9070204@prodmail.net>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 10:46:54 +0200
Message-Id: <1121417215.3179.7.camel@laptopd505.fenrus.org>
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

On Fri, 2005-07-15 at 13:56 +0530, RVK wrote:
> >except this is no longer true really ;)
> >
> >randomisation for example makes this a lot harder to do.
> >gcc level tricks to prevent buffer overflows are widely in use nowadays
> >too (FORTIFY_SOURCE and -fstack-protector). The combination of this all
> >makes it a LOT harder to actually exploit a buffer overflow on, say, a
> >distribution like Fedora Core 4.
> >
> >
> >  
> >
> Still is very new....not every one can immediately start using gcc 4.

it;s also available for gcc 3.4 as patch (and included in FC3 and RHEL4
for example)

so it's new? so what? doesn't make it less true that it nowadays is a
lot harder to exploit such bugs on recent distros.



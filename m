Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVCCJxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVCCJxj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVCCJxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:53:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37813 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261862AbVCCJvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:51:25 -0500
Subject: Re: RFD: Kernel release numbering
From: Arjan van de Ven <arjan@infradead.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050303094240.GC9796@ip68-4-98-123.oc.oc.cox.net>
References: <42265A6F.8030609@pobox.com>
	 <20050302165830.0a74b85c.davem@davemloft.net> <422674A4.9080209@pobox.com>
	 <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
	 <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>
	 <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
	 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
	 <20050303094240.GC9796@ip68-4-98-123.oc.oc.cox.net>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 10:51:13 +0100
Message-Id: <1109843474.6298.91.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 01:42 -0800, Barry K. Nathan wrote:
> On Thu, Mar 03, 2005 at 02:52:21AM -0500, Jeff Garzik wrote:
> > even/odd means that certain releases (even ones) are more magical than 
> > others.  That's weird, since users aren't used to that sort of thing in 
>                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > any other project.
> 
> Actually, we are:
> 
> Red Hat Linux 7.2:            not magical
> Red Hat Enterprise Linux 2.1:     magical
> Red Hat Linux 7.3:            not magical
> Red Hat Linux 8.0:            not magical
> Red Hat Linux 9:              not magical
> Red Hat Enterprise Linux 3.0:     magical
> Fedora Core 1:                not magical
> Fedora Core 2:                not magical
> Fedora Core 3:                not magical
> Red Hat Enterprise Linux 4.0:     magical
> Fedora Core 4:                not magical
> ...
> 
> Sure, Red Hat changes the name as well as the version number whenever they
> make a magical release, but it's really the same concept.

it's actually not. Red Hat Enterprise Linux is magical in that you get
actual support for it (in various degrees, depending on for what level
you want to pay). That is what sets it appart, not the actual bits.



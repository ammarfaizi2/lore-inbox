Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVAEHjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVAEHjV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 02:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbVAEHjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 02:39:21 -0500
Received: from canuck.infradead.org ([205.233.218.70]:20229 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262511AbVAEHjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 02:39:17 -0500
Subject: Re: starting with 2.7
From: Arjan van de Ven <arjan@infradead.org>
To: Felipe Alfaro Solana <lkml@mac.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E6D1C846-5EA4-11D9-A816-000D9352858E@mac.com>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
	 <20050102203615.GL29332@holomorphy.com>
	 <20050102212427.GG2818@pclin040.win.tue.nl>
	 <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com>
	 <20050103153438.GF2980@stusta.de>
	 <1104767943.4192.17.camel@laptopd505.fenrus.org>
	 <20050104174712.GI3097@stusta.de>
	 <Pine.LNX.4.60.0501041215500.9517@dlang.diginsite.com>
	 <E6D1C846-5EA4-11D9-A816-000D9352858E@mac.com>
Content-Type: text/plain
Date: Wed, 05 Jan 2005 08:39:11 +0100
Message-Id: <1104910751.4960.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002.6.10 or even 2.4.24 to 2.6.10
> >
> > anyone who assumes that just becouse the kernel is in the stable 
> > series they can blindly upgrade their production systems is just 
> > dreaming.
> r
> It's not a problem of blindly upgrading, but a problem of knowing that 
> most of the kernel interfaces do remain stable to reduce the number of 
> possible problems.

kernel interfaces have nothing to do with this.
kernel interfaces have zero relationship with stability of the software
although I do appreciate that you get in trouble if you need to link (in
my opinion) license violating kernel modules into your kernel. 



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271423AbTHHPvK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271686AbTHHPvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:51:10 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:4295 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S271423AbTHHPvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:51:06 -0400
Date: Fri, 8 Aug 2003 17:50:44 +0200
From: Jasper Spaans <jasper@vs19.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Timothy Miller <miller@techsource.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Message-ID: <20030808155044.GA12526@spaans.vs19.net>
References: <20030807180032.GA16957@spaans.vs19.net> <Pine.LNX.4.53.0308072139320.12875@montezuma.mastecende.com> <20030808065230.GA5996@spaans.vs19.net> <3F33BF33.8070601@techsource.com> <Pine.LNX.4.53.0308081127160.502@chaos>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308081127160.502@chaos>
Attach: /home/spaans/JasperSpaans.vcf
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2003 C. Jasper Spaans - All Rights Reserved
X-message-flag: Warning! The sender of this mail thinks you should use a more secure email client!
User-Agent: Mutt/1.5.4i
X-SA-Exim-Mail-From: spaans@spaans.vs19.net
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
Content-Type: text/plain; charset=iso-8859-15
X-SA-Exim-Version: 3.0+cvs (built Mon Jul 28 22:52:54 EDT 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > $ egrep -ni 'flavou?r' fs/nfs/inode.c
> > > 1357:	rpc_authflavor_t authflavour;

> However, changing the spelling of a variable name is
> absurd no matter how you look at it.

Read that line of code again please. Next, imagine writing code in there.

VrGr,
-- 
Jasper Spaans               http://jsp.vs19.net/contact/

<==  The only intuitive interface ever created was a   ==>
<==                      nipple.                       ==>

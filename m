Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271723AbTHHRda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 13:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271724AbTHHRda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 13:33:30 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:28105 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S271723AbTHHRd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 13:33:29 -0400
Date: Fri, 8 Aug 2003 19:33:21 +0200
From: Jasper Spaans <jasper@vs19.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Timothy Miller <miller@techsource.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Message-ID: <20030808173321.GB13818@spaans.vs19.net>
References: <3F33BF33.8070601@techsource.com> <Pine.LNX.4.44.0308081011550.27922-100000@home.osdl.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308081011550.27922-100000@home.osdl.org>
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

On Fri, Aug 08, 2003 at 10:18:41AM -0700, Linus Torvalds wrote:

> > > 1357:	rpc_authflavor_t authflavour;
> This one I think is valid. Considering how many people seem to care, I 
> think we should keep it as the only valid case for now.

Right. I'll whip up a patch that is somewhat more subtle... minimizing the
damage done to other files.

> I think you guys who care should have a huge free-for-all, an electronic
> mud-wrestling thing if you will. But not on linux-kernel. 
> ...

:D

VrGr,
-- 
Jasper Spaans               http://jsp.vs19.net/contact/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVCCUeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVCCUeY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVCCUa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:30:27 -0500
Received: from khc.piap.pl ([195.187.100.11]:56836 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S262119AbVCCU2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:28:24 -0500
To: Chris Wright <chrisw@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
	<42268749.4010504@pobox.com>
	<20050302200214.3e4f0015.davem@davemloft.net>
	<42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
	<20050302205826.523b9144.davem@davemloft.net>
	<4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com>
	<4226CA7E.4090905@pobox.com>
	<Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	<20050303165533.GQ28536@shell0.pdx.osdl.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 03 Mar 2005 21:26:33 +0100
In-Reply-To: <20050303165533.GQ28536@shell0.pdx.osdl.net> (Chris Wright's
 message of "Thu, 3 Mar 2005 08:55:33 -0800")
Message-ID: <m3mztkv5l2.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> writes:

> I like this definition.  The only remaining question is what determines
> a 2.6.x.y release?  One patch?  Sure if it's critical enough.  

Sure. Or a patch for 1-2 days, will less critical things.

And probably no .tar* balls for them. Just a patch against 2.6.x.y-1.
-- 
Krzysztof Halasa

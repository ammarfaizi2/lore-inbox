Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbVCDJox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVCDJox (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVCDJox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:44:53 -0500
Received: from khc.piap.pl ([195.187.100.11]:58628 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S262576AbVCDJou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 04:44:50 -0500
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
	<1109882043.4032.79.camel@tglx.tec.linutronix.de>
	<42277C81.4010302@pobox.com>
	<200503031842.23937.gene.heskett@verizon.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 04 Mar 2005 10:43:00 +0100
In-Reply-To: <200503031842.23937.gene.heskett@verizon.net> (Gene Heskett's
 message of "Thu, 03 Mar 2005 18:42:23 -0500")
Message-ID: <m38y53vja3.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> writes:

> I've seen this comment before too, and I still think it says it best:
>
> The full release s/b the last rc with NO changes other than its name.
>
> Now we are faced with a final that may have another 50k+ of patches 
> applied over what made the rc5.  IMO, in the immediately past case, 
> that should not have been final, but an rc6.

Not sure about it. I think last-rc -> final diff should be allowed
to contain trivial patches, like those qualified for 2.6.x.y.
-- 
Krzysztof Halasa

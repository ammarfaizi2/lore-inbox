Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272291AbTGaBuK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 21:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272312AbTGaBuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 21:50:10 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:24998 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S272291AbTGaBuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 21:50:07 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernardo Innocenti <bernie@develer.com>,
       Willy Tarreau <willy@w.ods.org>, Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6 size increase
References: <200307232046.46990.bernie@develer.com>
	<200307240007.15377.bernie@develer.com>
	<20030723222747.GF643@alpha.home.local>
	<200307242227.16439.bernie@develer.com>
	<20030729222921.GK16051@ip68-0-152-218.tc.ph.cox.net>
	<1059518889.6838.19.camel@dhcp22.swansea.linux.org.uk>
	<20030729230657.GL16051@ip68-0-152-218.tc.ph.cox.net>
	<buoptjsepib.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20030730153311.GA27214@ip68-0-152-218.tc.ph.cox.net>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 31 Jul 2003 10:49:06 +0900
In-Reply-To: <20030730153311.GA27214@ip68-0-152-218.tc.ph.cox.net>
Message-ID: <buoel07tqi5.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> writes:
> > but not nice enough to justify requiring more memory or whatever (of
> > course just that one feature's not going to make much difference,
> > but in aggregate, they might).
> 
> Well, that sort-of depends on which 'embedded' board you're talking
> about really.

The point was that in _some_ embedded systems, the space-savings is
wanted, and so a useful thing for linux to support.

-Miles
-- 
Suburbia: where they tear out the trees and then name streets after them.

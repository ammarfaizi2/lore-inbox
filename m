Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273906AbTG3PdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 11:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273909AbTG3PdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 11:33:16 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:39299 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S273906AbTG3PdM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 11:33:12 -0400
Date: Wed, 30 Jul 2003 08:33:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Miles Bader <miles@gnu.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernardo Innocenti <bernie@develer.com>,
       Willy Tarreau <willy@w.ods.org>, Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6 size increase
Message-ID: <20030730153311.GA27214@ip68-0-152-218.tc.ph.cox.net>
References: <200307232046.46990.bernie@develer.com> <200307240007.15377.bernie@develer.com> <20030723222747.GF643@alpha.home.local> <200307242227.16439.bernie@develer.com> <20030729222921.GK16051@ip68-0-152-218.tc.ph.cox.net> <1059518889.6838.19.camel@dhcp22.swansea.linux.org.uk> <20030729230657.GL16051@ip68-0-152-218.tc.ph.cox.net> <buoptjsepib.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buoptjsepib.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 11:07:24AM +0900, Miles Bader wrote:
> Tom Rini <trini@kernel.crashing.org> writes:
> > And wouldn't it be nice to have one 'policy enforcing tool' or whatever
> > that you feed it policy_desktop.txt, policy_embedded_in_my_fridge.txt or
> > policy_enterprise.txt ?
> 
> Sure, but not nice enough to justify requiring more memory or whatever
> (of course just that one feature's not going to make much difference,
> but in aggregate, they might).

Well, that sort-of depends on which 'embedded' board you're talking
about really.  And the trade-off between the work needed for a hacked-up
1 off, the space that could be saved by doing this, and the space that
could be saved elsewhere.  Perhaps on the embedded_in_my_fridge machine
it might make sense, but not ever embedded device is quite so tiny and
strapped for space.

-- 
Tom Rini
http://gate.crashing.org/~trini/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVBSK5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVBSK5E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 05:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVBSK5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 05:57:04 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:60136 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261692AbVBSK5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 05:57:00 -0500
Subject: Re: Should kirqd work on HT?
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1108805793.6304.75.camel@laptopd505.fenrus.org>
References: <1108794699.4098.28.camel@desktop.cunningham.myip.net.au>
	 <4216E248.5070603@pobox.com>
	 <1108804063.4098.35.camel@desktop.cunningham.myip.net.au>
	 <1108805793.6304.75.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Message-Id: <1108810730.4098.44.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 19 Feb 2005 21:58:50 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

Didn't realise it was going to take nothing to install, so I've done it.
IRQs are running on cpu 1 now. Is there some documentation somewhere?
I'm wondering whether I can compile kirqd out.

Thanks and regards,

Nigel

On Sat, 2005-02-19 at 20:36, Arjan van de Ven wrote:
> On Sat, 2005-02-19 at 20:07 +1100, Nigel Cunningham wrote:
> > Hi Jeff.
> > 
> > On Sat, 2005-02-19 at 17:52, Jeff Garzik wrote:
> > > Nigel Cunningham wrote:
> > > What are the results of running irqbalanced?
> > 
> > You mean the debugging output? I can reenable it and record the results
> > if that's what you mean.
> 
> no Jeff meant
> http://people.redhat.com/arjanv/irqbalance/
> that app most likely....
> 
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574


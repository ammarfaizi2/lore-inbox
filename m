Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWIUIuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWIUIuT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 04:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWIUIuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 04:50:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47322 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750821AbWIUIuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 04:50:17 -0400
Subject: Re: 2.6.19 -mm merge plans
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0609202217420.4388@g5.osdl.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	 <45121382.1090403@garzik.org> <20060920220744.0427539d.akpm@osdl.org>
	 <Pine.LNX.4.64.0609202217420.4388@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Sep 2006 10:12:38 +0100
Message-Id: <1158829958.11109.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-20 am 22:23 -0700, ysgrifennodd Linus Torvalds:
> 
> On Wed, 20 Sep 2006, Andrew Morton wrote:
> > 
> > Why would a shorter cycle be better?  What are we trying to achieve?
> 
> I don't think a shorter cycle is necessarily better, but I think we could 
> try having a more "directed" cycle, and perhaps merge certain specific 
> things rather than everything.

Works for me. We do need to keep pushing drivers each cycle (and we need
faster cycles just to keep up with the chipset people) but a situation
where people are told to keep those driver updates working with the old
core code would be fine (ie as 2.4 sometimes was) for some of the cycles
when they are not the goal.

Alan


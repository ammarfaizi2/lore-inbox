Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbVLWIJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbVLWIJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 03:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbVLWIJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 03:09:28 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:32471 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030456AbVLWIJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 03:09:28 -0500
Date: Fri, 23 Dec 2005 09:09:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Pitre <nico@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 0/8] mutex subsystem, -V6
Message-ID: <20051223080901.GB9614@elte.hu>
References: <20051222230438.GA13302@elte.hu> <Pine.LNX.4.64.0512221846470.26663@localhost.localdomain> <Pine.LNX.4.64.0512222359360.26663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512222359360.26663@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nicolas Pitre <nico@cam.org> wrote:

> On Thu, 22 Dec 2005, Nicolas Pitre wrote:
> 
> > > Nico, Christoph, does this approach work for you? Nico, you might want 
> > > to try an ARM-specific mutex.h implementation.
> > 
> > Yes, I'm happy.  And the ARM version will be sent your way soon.
> 
> Here it is:

cool! I've merged it - and the end-result looks really clean.

	Ingo

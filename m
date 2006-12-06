Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936888AbWLFRBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936888AbWLFRBU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936694AbWLFRBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:01:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33699 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936888AbWLFRAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:00:54 -0500
Date: Wed, 6 Dec 2006 17:59:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
Message-ID: <20061206165934.GA17527@elte.hu>
References: <20061204204024.2401148d.akpm@osdl.org> <Pine.LNX.4.64.0612060348150.1868@scrub.home> <20061205203013.7073cb38.akpm@osdl.org> <1165393929.24604.222.camel@localhost.localdomain> <Pine.LNX.4.64.0612061334230.1867@scrub.home> <20061206131155.GA8558@elte.hu> <Pine.LNX.4.64.0612061422190.1867@scrub.home> <20061206152244.GA24613@elte.hu> <Pine.LNX.4.64.0612061633230.1867@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061633230.1867@scrub.home>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > It cannot be had both ways: either we stay simpler and less 
> > intrusive, or we go more generic but more intrusive.
> 
> You miss the point, I don't care how intrusive this is, [...]

we do care about how intrusive this is. I guess we'll have to agree to 
disagree on that.

	Ingo

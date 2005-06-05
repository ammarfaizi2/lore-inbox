Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVFEPVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVFEPVv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 11:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVFEPVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 11:21:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37115 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261472AbVFEPVt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 11:21:49 -0400
Date: Sun, 5 Jun 2005 08:21:45 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, plist fixes
In-Reply-To: <1117984662.20785.295.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.10.10506050820420.13184-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Jun 2005, Thomas Gleixner wrote:

> On Sun, 2005-06-05 at 07:51 -0700, Daniel Walker wrote:
> 
> > __plist_del was a good fix. I attached a patch on "Plist cleanup on RT" to
> > lkml with what was acceptable to me. A good 60% of Thomas's changes are
> > unacceptable to me.
> 
> Would you be so kind to explain that a bit ? Your patch contains _all_
> my proposed changes except the additional plist_first_entry macro and
> the comment cleanup.
> 
> So what are the 60% which are unacceptable. Comments ? I'm amused.

Whatever was missing was unacceptable. 

Daniel


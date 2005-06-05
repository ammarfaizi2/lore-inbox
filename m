Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVFEPRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVFEPRP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 11:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVFEPRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 11:17:15 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:63107
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261585AbVFEPRM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 11:17:12 -0400
Subject: Re: [patch] Real-Time Preemption, plist fixes
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <Pine.LNX.4.10.10506050749310.10127-100000@godzilla.mvista.com>
References: <Pine.LNX.4.10.10506050749310.10127-100000@godzilla.mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 05 Jun 2005 17:17:42 +0200
Message-Id: <1117984662.20785.295.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-05 at 07:51 -0700, Daniel Walker wrote:

> __plist_del was a good fix. I attached a patch on "Plist cleanup on RT" to
> lkml with what was acceptable to me. A good 60% of Thomas's changes are
> unacceptable to me.

Would you be so kind to explain that a bit ? Your patch contains _all_
my proposed changes except the additional plist_first_entry macro and
the comment cleanup.

So what are the 60% which are unacceptable. Comments ? I'm amused.

tglx



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbVAKKxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbVAKKxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 05:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVAKKvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 05:51:55 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:29330
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262708AbVAKKvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 05:51:45 -0500
Subject: Re: User space out of memory approach
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Edjard Souza Mota <edjard@gmail.com>, Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <20050111074230.GB18796@logos.cnet>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <20050111074230.GB18796@logos.cnet>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 11:51:38 +0100
Message-Id: <1105440698.17853.102.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 05:42 -0200, Marcelo Tosatti wrote:
> > are not fixed properly, we don't need to discuss the inclusion of a
> > userspace provided candidate list.
> > 
> > Postpone this until the main problem is fixed. There is a proper
> > confirmed fix for this available. It was posted more than once.
> 
> Agreed - haven't you and Andrea fixed those recently ?

Yep. The fixes are around for quite a while and Andrea is bringing the
fixes up to kernel current, if I understood one of his previous mails
correctly.

tglx



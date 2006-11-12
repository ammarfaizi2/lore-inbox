Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752916AbWKLTiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbWKLTiy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 14:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917AbWKLTiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 14:38:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1737 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752902AbWKLTix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 14:38:53 -0500
Date: Sun, 12 Nov 2006 11:34:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       David Howells <dhowells@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru, mingo@redhat.com
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
Message-Id: <20061112113408.c93e27b1.akpm@osdl.org>
In-Reply-To: <200611122019.09851.ioe-lkml@rameria.de>
References: <200611111129.kABBTWgp014081@fire-2.osdl.org>
	<20061112125357.GH25057@stusta.de>
	<1163337376.3293.120.camel@laptopd505.fenrus.org>
	<200611122019.09851.ioe-lkml@rameria.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2006 20:18:51 +0100
Ingo Oeser <ioe-lkml@rameria.de> wrote:

> Hi there,
> 
> On Sunday, 12. November 2006 14:16, Arjan van de Ven wrote:
> > If this isn't UP this could be the first real case of "noapic" in your
> > entire list...... which isn't too useful. 
> > Maybe we need to get more/any people who see "need noapic on SMP" to
> > file a bug (and provide a reasonable amount of info)
> 
> I need noapic since ever (5 years!) to get my USB controller running.
> Without noapic it doesn't get any interrupts for some reason.
> 
> If now is the time to fix those bugs, I would be happy to try a new kernel
> and get you the dmesg + result of plugging in an usb mass storage device
> and reading from it on a DAILY basis.

Yes, please send those.  It'd be best to get the info into bugzilla too -
this doesn't look like a quick-fix scenario.



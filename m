Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVAGA6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVAGA6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVAGAs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:48:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:4225 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261153AbVAGApb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:45:31 -0500
Date: Thu, 6 Jan 2005 16:49:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: bzolnier@gmail.com, drab@kepler.fjfi.cvut.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: APIC/LAPIC hanging problems on nForce2 system.
Message-Id: <20050106164952.0a46df7e.akpm@osdl.org>
In-Reply-To: <41DDD7C3.8040406@gmx.de>
References: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz>
	<41DC1AD7.7000705@gmx.de>
	<Pine.LNX.4.60.0501051757300.25946@kepler.fjfi.cvut.cz>
	<41DC2113.8080604@gmx.de>
	<Pine.LNX.4.60.0501051821430.25946@kepler.fjfi.cvut.cz>
	<41DC2353.7010206@gmx.de>
	<Pine.LNX.4.60.0501060046450.26952@kepler.fjfi.cvut.cz>
	<41DCFEF0.5050105@gmx.de>
	<58cb370e05010605527f87297e@mail.gmail.com>
	<41DD537B.9030304@gmx.de>
	<20050106154650.33c3b11c.akpm@osdl.org>
	<41DDD7C3.8040406@gmx.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Prakash K. Cheemplavam" <prakashkc@gmx.de> wrote:
>
> Perhaps firfox fscked up the inlined patch, so please
> try the attached version. If it goes alright, I'll resubmit it,
> inlcuding more detailed description.

There was no attachment.

Please go ahead and prepare a final patch against Linus's latest tree.  The
simplest way to obtain that is via the topmost link at
http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/.

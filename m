Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbUDTBGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUDTBGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 21:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUDTBGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 21:06:41 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:2829 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261568AbUDTBGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 21:06:40 -0400
Date: Tue, 20 Apr 2004 09:13:11 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1
In-Reply-To: <20040419202538.A15701@infradead.org>
Message-ID: <Pine.LNX.4.58.0404200911090.12229@wombat.indigo.net.au>
References: <20040418230131.285aa8ae.akpm@osdl.org> <20040419202538.A15701@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, REPLY_WITH_QUOTES,
	USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004, Christoph Hellwig wrote:

> 4-autofs4-2.6.0-expire-20040405.patch exports vfsmount_lock which is probably
> not exactly a good design.  It's only used by autofs4_may_umount which isn't
> autofs-specific at all.
> 

Sorry Christoph, your recommendation is?

Ian


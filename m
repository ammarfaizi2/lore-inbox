Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUBIQNS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 11:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUBIQNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 11:13:18 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:31497 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S265210AbUBIQNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 11:13:16 -0500
Date: Tue, 10 Feb 2004 00:13:30 +0800 (WST)
From: raven@themaw.net
To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
cc: =?koi8-r?Q?=22?=Kernel Mailing List=?koi8-r?Q?=22=20?= 
	<linux-kernel@vger.kernel.org>,
       =?koi8-r?Q?=22?=autofs mailing list=?koi8-r?Q?=22=20?= 
	<autofs@linux.kernel.org>,
       nfs@lists.sourceforge.net
Subject: Re[3]: [NFS] nfs or autofs related hangs
In-Reply-To: <E1AqDZO-000G5Z-00.ia6432-inbox-ru@f22.mail.ru>
Message-ID: <Pine.LNX.4.58.0402100010260.1818@raven.themaw.net>
References: <E1AqDZO-000G5Z-00.ia6432-inbox-ru@f22.mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Feb 2004, [koi8-r] "Peter Lojkin[koi8-r] "  wrote:

> On Mon, 9 Feb 2004 at 23:21:12 +0800 Ian Kent wrote:
> 
> > > > Could you try this patch please.
> > > ok, i'll test it and let you know.
> > > but it may take up to several days or week...
> > 
> > No problem.
> > 
> > The patch is against my 20031201 autofs4.
> > If you wish to test against a vanila kernel I'll need to revise it.
> i'll test this patch with our 2.4.23aa1 + autofs4-20031201 and
> 2.4.25-rc1 + autofs4-20031201 (should it work?)...
> 

Think so.

I haven't looked at the aa patches or 2.4.25. I'm not aware of any changes 
to autofs4 but I've not been paying much attention to the 2.4 series.

Let me know if there is a problem.

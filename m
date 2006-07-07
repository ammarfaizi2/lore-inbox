Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWGGMbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWGGMbN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWGGMbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:31:13 -0400
Received: from mail.gmx.net ([213.165.64.21]:39302 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932145AbWGGMbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:31:11 -0400
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain; charset="utf-8"
Date: Fri, 07 Jul 2006 14:31:10 +0200
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
In-Reply-To: <20060707122850.GU4188@suse.de>
Message-ID: <20060707123110.64140@gmx.net>
MIME-Version: 1.0
References: <20060707070703.165520@gmx.net>
 <20060707040749.97f8c1fc.akpm@osdl.org> <20060707114235.243260@gmx.net>
 <20060707120333.GR4188@suse.de> <20060707122850.GU4188@suse.de>
Subject: Re: splice/tee bugs?
To: Jens Axboe <axboe@suse.de>, mtk-manpages@gmx.net
X-Authenticated: #2864774
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> > > > >    In this case I can't kill it with ^C or ^\.  This is a 
> > > > >    hard-to-reproduce behaviour on my (x86) system, but I have 
> > > > >    seen it several times by now.
> > > > 
> > > > aka local DoS.  Please capture sysrq-T output next time.
[...]
> > I'll see about reproducing locally.
> 
> With your modified ktee, I can reproduce it here. Here's the ktee and wc
> output:

Good; thanks.

By the way, what about points a) and b) in my original mail
in this thread?

Cheers,

Michael
-- 


"Feel free" – 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail

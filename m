Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280033AbRJ3Qzz>; Tue, 30 Oct 2001 11:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280028AbRJ3Qzi>; Tue, 30 Oct 2001 11:55:38 -0500
Received: from [208.129.208.52] ([208.129.208.52]:34313 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S280025AbRJ3QzR>;
	Tue, 30 Oct 2001 11:55:17 -0500
Date: Tue, 30 Oct 2001 09:02:54 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
In-Reply-To: <20011030034058.B21884@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.40.0110300900190.1495-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Mike Fedyk wrote:

> On Mon, Oct 29, 2001 at 09:38:07PM -0800, Davide Libenzi wrote:
> > 2) My Linux Scheduler Stuff Page:
> > 	http://www.xmailserver.org/linux-patches/lnxsched.html
> >
>
> Anyone know if this is preempt safe?  It's using processor specific lists,
> and might not be.

Processor specific lists ?
The mss scheduler patch in for x86 but it's trivial ( about 10 lines of
code ) to port it to other arcs.




- Davide



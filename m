Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbUJXKYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbUJXKYp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 06:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUJXKYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 06:24:45 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:43741 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261429AbUJXKYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 06:24:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=SdChl3GHjoby0l8HJFvUHbWKHbLvT8hvbo1TUcEdmLZWXGep9yrGSx6qaosm8R495CykMwVWgPPYA10OJWSHEd+QWGvpqkktcvDyryM+uAeUbU58QaVf3DbLRgIdluwzOKtrECAkeUZlZ33Ik0fyaQdUw7sEzPxxXBsrRRzm8z4=
Message-ID: <4d8e3fd304102403241e5a69a5@mail.gmail.com>
Date: Sun, 24 Oct 2004 12:24:42 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Larry McVoy <lm@work.bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <20041023161253.GA17537@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41752E53.8060103@pobox.com>
	 <20041019153126.GG18939@work.bitmover.com>
	 <41753B99.5090003@pobox.com>
	 <4d8e3fd304101914332979f86a@mail.gmail.com>
	 <20041019213803.GA6994@havoc.gtf.org>
	 <4d8e3fd3041019145469f03527@mail.gmail.com>
	 <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>
	 <20041023161253.GA17537@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004 09:12:53 -0700, Larry McVoy <lm@bitmover.com> wrote:
> On Tue, Oct 19, 2004 at 03:11:55PM -0700, Linus Torvalds wrote:
> > On Tue, 19 Oct 2004, Paolo Ciarrocchi wrote:
> > > I know I'm pedantic but can we all see the list of bk trees ("patches
> > > ready for mainstream" and "patches eventually ready for mainstream")
> > > that we'll be used by Linus ?
> >
> > Even _I_ don't have that kind of list.
> 
> I don't know how you could have that sort of list.  We have some idea
> of the potential size of that list and it's huge.  Based on the lease
> requests back to us (BK is lease based, it connects back to us once a
> month), we estimate that there well over 10,000 clones of the Linux kernel
> in BK.  If even 1/10th of those are going to have a patch for Linus that's
> 1,000 potential patches.  Pretty hard to keep that all in your head.

Well, I'm not interested in having the list of all the bk trees used
during the develpoment of a release.
I was looking to the trees used by mantainers.
That number should me really different from "1,000".
Do you agree ?

CIao,
-- 
Paolo
Personal home page: www.ciarrocchi.tk
Picasa users groups: www.picasa-users.tk
join the blog group: http://groups-beta.google.com/group/blog-users

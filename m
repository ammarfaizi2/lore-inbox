Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276074AbRJUNgq>; Sun, 21 Oct 2001 09:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276057AbRJUNgg>; Sun, 21 Oct 2001 09:36:36 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:63496 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S276074AbRJUNgW>; Sun, 21 Oct 2001 09:36:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Jan-Frode Myklebust <janfrode@parallab.uib.no>
Subject: Re: bk regression fails on tmpfs /tmp, was: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
Date: Sun, 21 Oct 2001 09:36:55 -0400
X-Mailer: KMail [version 1.3.2]
Cc: Christoph Rohland <cr@sap.com>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <016a01c15831$ef51c5c0$5c044589@legato.com> <E15vI6n-0001oC-00@ii.uib.no> <20011021151038.A5943@ii.uib.no>
In-Reply-To: <20011021151038.A5943@ii.uib.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011021133632Z276074-17408+2966@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 October 2001 09:10, Jan-Frode Myklebust wrote:
> On Sun, Oct 21, 2001 at 08:53:38AM -0400, safemode wrote:
> > On Sunday 21 October 2001 08:34, Jan-Frode Myklebust wrote:
> > > > Like someone said before a while ago.  This is a binutils problem.
> > > > Update to a newer version.
> > >
> > > Upgraded to binutils 2.11.92.0.7, but it didn't help.
>
> [snip]
>
> > 2.11.92.0.7-2 works fine
> > and just to let you know,  You wont see any gain in compile time unless
> > your drive is running on Pio Mode. In which case I think compile time for
> > the kernel is the least bit of your hdd load time worries.
>
> oh.., I think you're confusing my problem with the problem mentioned in
> the subject, sorry for not changing it before. Anyway, can't find any
> 2.11.92.0.7-2 on
> ftp://ftp.no.kernel.org/linux/kernel.org/pub/linux/devel/binutils/
>
>

Since you were having trouble with the current build of binutils i assumed 
you were using debian since a fix in the build fixed the problem for me.  I 
was having the exact same error you submitted in your first mail. 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276018AbRJUNKW>; Sun, 21 Oct 2001 09:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276021AbRJUNKM>; Sun, 21 Oct 2001 09:10:12 -0400
Received: from eik.ii.uib.no ([129.177.16.3]:10898 "EHLO ii.uib.no")
	by vger.kernel.org with ESMTP id <S276018AbRJUNKF>;
	Sun, 21 Oct 2001 09:10:05 -0400
Date: Sun, 21 Oct 2001 15:10:38 +0200
From: Jan-Frode Myklebust <janfrode@parallab.uib.no>
To: safemode <safemode@speakeasy.net>
Cc: Christoph Rohland <cr@sap.com>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: bk regression fails on tmpfs /tmp, was: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
Message-ID: <20011021151038.A5943@ii.uib.no>
In-Reply-To: <016a01c15831$ef51c5c0$5c044589@legato.com> <E15vHVx-0001Nc-00@ii.uib.no> <20011021143409.A4900@ii.uib.no> <E15vI6n-0001oC-00@ii.uib.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15vI6n-0001oC-00@ii.uib.no>; from safemode@speakeasy.net on Sun, Oct 21, 2001 at 08:53:38AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 08:53:38AM -0400, safemode wrote:
> On Sunday 21 October 2001 08:34, Jan-Frode Myklebust wrote:
> > > Like someone said before a while ago.  This is a binutils problem. 
> > > Update to a newer version.
> >
> > Upgraded to binutils 2.11.92.0.7, but it didn't help.
> >

[snip]


> 2.11.92.0.7-2 works fine 
> and just to let you know,  You wont see any gain in compile time unless your 
> drive is running on Pio Mode. In which case I think compile time for the 
> kernel is the least bit of your hdd load time worries. 
> 


oh.., I think you're confusing my problem with the problem mentioned in
the subject, sorry for not changing it before. Anyway, can't find any
2.11.92.0.7-2 on
ftp://ftp.no.kernel.org/linux/kernel.org/pub/linux/devel/binutils/


  -jf

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311647AbSCNQMH>; Thu, 14 Mar 2002 11:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311646AbSCNQMA>; Thu, 14 Mar 2002 11:12:00 -0500
Received: from dsl-213-023-038-002.arcor-ip.net ([213.23.38.2]:36259 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311645AbSCNQLw>;
	Thu, 14 Mar 2002 11:11:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Dan Kegel <dkegel@ixiacom.com>, Ulrich Drepper <drepper@redhat.com>
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem   (one li\ne)>
Date: Thu, 14 Mar 2002 17:07:09 +0100
X-Mailer: KMail [version 1.3.2]
Cc: darkeye@tyrell.hu, libc-gnats@gnu.org, gnats-admin@cygnus.com, sam@zoy.org,
        Xavier Leroy <Xavier.Leroy@inria.fr>, linux-kernel@vger.kernel.org,
        babt@us.ibm.com
In-Reply-To: <1016062486.16743.1091.camel@myware.mynet> <3C8FEC76.F1411739@ixiacom.com>
In-Reply-To: <3C8FEC76.F1411739@ixiacom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16lXkz-0000S3-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 14, 2002 01:19 am, Dan Kegel wrote:
> Ulrich Drepper wrote:
> > On Wed, 2002-03-13 at 15:17, Dan Kegel wrote:
> > 
> > > So let's break the logjam and fix glibc's linuxthreads' pthread_create
> > > to [support profiling multithreaded programs]
> > 
> > I will add nothing like this.  The implementation is broken enough and
> > any addition just makes it worse.  If you patch your own code you'll get
> > what you want at your own risk.
> 
> OK.  What's the right way to fix this, then?

I see, he said to patch your own code and probably feels the issue is done with.
Color me less than impressed.

-- 
Daniel

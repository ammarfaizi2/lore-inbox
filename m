Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292408AbSCDQHS>; Mon, 4 Mar 2002 11:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292423AbSCDQHH>; Mon, 4 Mar 2002 11:07:07 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:5857 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292408AbSCDQHB>;
	Mon, 4 Mar 2002 11:07:01 -0500
Date: Mon, 4 Mar 2002 11:07:03 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Martin Wirth <martin.wirth@dlr.de>, rusty@rustycorp.com.au,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020304110703.A1116@elinux01.watson.ibm.com>
In-Reply-To: <20020302090856.A1332@elinux01.watson.ibm.com> <Pine.SGI.4.21.0203031410310.623951-100000@sam.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SGI.4.21.0203031410310.623951-100000@sam.engr.sgi.com>; from pj@engr.sgi.com on Sun, Mar 03, 2002 at 02:13:45PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2002 at 02:13:45PM -0800, Paul Jackson wrote:
> On Sat, 2 Mar 2002, Hubertus Franke wrote:
> > But more conceptually, if you process dies while holding a lock ... 
> > your app is toast at that point.
> 
> Without application specific knowledge, certainly.
> 
> Is there someway one could support a hook, to enable
> an application to register a handler that could clean
> up, for those apps that found that worthwhile?
> 

I think that's a good idea,  I'll think it through and see what Rusty thinks.


> -- 
>                           I won't rest till it's the best ...
>                           Programmer, Linux Scalability
>                           Paul Jackson <pj@sgi.com> 1.650.933.1373

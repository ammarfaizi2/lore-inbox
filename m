Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267590AbSLFUqD>; Fri, 6 Dec 2002 15:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267587AbSLFUqC>; Fri, 6 Dec 2002 15:46:02 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18320 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267590AbSLFUqC>;
	Fri, 6 Dec 2002 15:46:02 -0500
Message-Id: <200212062053.gB6KrOF27322@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: scott-kernel@thomasons.org
cc: "Richard B. Tilley " "(Brad)" <rtilley@vt.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cliffw@osdl.org
Subject: Re: Kernel Test tools 
In-Reply-To: Message from scott thomason <scott-kernel@thomasons.org> 
   of "Tue, 03 Dec 2002 19:29:04 CST." <200212031929.04972.scott-kernel@thomasons.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Dec 2002 12:53:24 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tuesday 03 December 2002 07:04 am, Richard B. Tilley " "(Brad) 
> wrote:
> > Where can one find programs to comparison test or stress test beta
> > kernels?
> 
> Google for these downloads (I don't have the original URLs):
> 
> bench-20010103.tar.gz
> contest-0.51.tar.gz
> glibench-0.2.5.tar.gz
> lmbench-2.0.3.tgz
> lots_of_forks.sh
> ltp-20021107.tgz
> mongo.tar.bz2
> s7110.tar.Z
> s9110.tar.Z
> slab-bench.tar.gz
> tiobench-0.3.3.tar.gz
> unixbench-4.1.0.tgz
> vmregress-0.7.tar.gz
> 

You can get most of these from the STP CVS tree on Sourceforge.
They are in the 'tests' module
cvs -d:pserver:anonymous@cvs.stp.sourceforge.net:/cvsroot/stp login
 
cvs -z3 -d:pserver:anonymous@cvs.stp.sourceforge.net:/cvsroot/stp co tests

We don't have mongo, glibench or lots-of-forks, but i think we 
have the rest.
cliffw

> I think I found a lot of these via Freshmeat and SourceForge IIRC.
> ---scott
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



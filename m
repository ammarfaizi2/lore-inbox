Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317049AbSEWXbj>; Thu, 23 May 2002 19:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317050AbSEWXbi>; Thu, 23 May 2002 19:31:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:19171 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317049AbSEWXbh>;
	Thu, 23 May 2002 19:31:37 -0400
Date: Thu, 23 May 2002 16:34:39 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Austin Gonyou <austin@digitalroadkill.net>, linux-kernel@vger.kernel.org
cc: hannal@us.ibm.com
Subject: Re: Recent kernel SMP scalability Benchmark/White-paper References.
Message-ID: <3500000.1022196878@w-hlinder.des>
In-Reply-To: <1022193715.7292.74.camel@UberGeek>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Austin,

	Check out http://lse.sourceforge.net
and	http://sourceforge.net/projects/lse

(lse= linux scalability effort)

That might be more information than you were looking for.
Another good resource is the lse mailing list at: 
lse-tech@lists.sourceforge.net

We have bi-weekly conference calls where anyone is welcome
to join and ask questions or report your work or whatever.

As a developer working on SMP scalability on Linux I would 
say it is getting better but we still have work to do. 

Hanna Linder
IBM Linux Technology Center


--On Thursday, May 23, 2002 17:41:55 -0500 Austin Gonyou <austin@digitalroadkill.net> wrote:

> I was looking around on google web, google groups, lkml digests,
> Intel.com, RedHat, SuSe, SGI.com, osdl.com, etc for some benchmarks of
> recent 2.4.x kernels, say 2.4.x > 16, with references to SMP scalability
> problems or successes, etc. Mainly centering around 4-way/8-way x86
> testing in terms of memory bandwidth/utilization, threading performance,
> etc. 
> 
> I've not found much in my search so far, and thought at this point it
> might be best to ask on this list to help shorten the search a bit, if
> possible. Of the documents I do have, they're more marketing based and
> not really *technology* based or touch very heavily as to generic
> benchmarking of a standard Linux kernel on SMP. 
> 
> I'm hoping to create a white-paper internally, and hopefully externally
> at some point, which can be maintained so others don't have to do the
> same arduous task of trying to find recent data as it pertains to said
> statistics. 
> 
> Any help as to recent documentation of this nature would be *overly*
> appreciated! 
> 
> In addition to this info, I'm trying to gather information as it
> pertains to the scalability of Linux kernels on 4/8-way x86 systems
> versus Solaris Sparc 4/8-way systems with measurements of the same
> statistics. 
> 
> I fear I'm searching for a document which does not exist. TIA.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



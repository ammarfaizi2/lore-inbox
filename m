Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317341AbSFCJwE>; Mon, 3 Jun 2002 05:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317342AbSFCJwD>; Mon, 3 Jun 2002 05:52:03 -0400
Received: from codepoet.org ([166.70.14.212]:41959 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S317341AbSFCJwC>;
	Mon, 3 Jun 2002 05:52:02 -0400
Date: Mon, 3 Jun 2002 03:52:03 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Philippe Gerum <rpm@idealx.com>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Message-ID: <20020603095202.GA16392@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Karim Yaghmour <karim@opersys.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Philippe Gerum <rpm@idealx.com>
In-Reply-To: <3CFB2A38.60242CBA@opersys.com> <20020603084606.GA15986@codepoet.org> <3CFB3378.5EB7420@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jun 03, 2002 at 05:14:32AM -0400, Karim Yaghmour wrote:
> >  What is the
> > software patent outlook for this approach look like?
> 
> Alessandro's answer is to the point. Basically, grab the papers,
> the code and the patent and have a look for yourself, you will see
> that we're clear. Apart from having the kernels side-by-side,
> Adeos is based on classic early '90s nanokernel work. No secrets
> there.

So will we soon be seeing a port of RTAI to a linux kernel module
which is implemented as a separate Adeos domain, allowing RTAI
apps to bypass US patent 5995745?  A quick glance over that
patent leaves me uncertain whether this indeed bypasses the
fundamental "invention" of a "process for running a general
purpose computer operating system using a real time operating
system".   It still looks to me like a real time operating system
(Adeos) running real time and non-real time tasks with a general
purpose operating system as one of the non-real time tasks...
Could you summarize (for non-lawyers such as myself) how this
bypasses the claims in the patent?  

Hopeful is,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

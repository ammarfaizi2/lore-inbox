Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313424AbSC2KQ6>; Fri, 29 Mar 2002 05:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313423AbSC2KQj>; Fri, 29 Mar 2002 05:16:39 -0500
Received: from linux.kappa.ro ([194.102.255.131]:35535 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S313424AbSC2KQ2>;
	Fri, 29 Mar 2002 05:16:28 -0500
Date: Fri, 29 Mar 2002 12:13:08 +0200
From: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
To: Irwan Hadi <irwanhadi@phxby.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Having too many access lists in Linux
Message-ID: <20020329101308.GA2380@linux.kappa.ro>
In-Reply-To: <20020328191705.C17277@phxby.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have in use a linux router having about 1400 iptables rules, doing
cbq with 450 entries, doing bgp and ospf also with 1200 routes, it
is a dual PIII 667 and most of the time it has about 75% percent
free processor, and also through it we have about 30Mbps average ..

On Thu, Mar 28, 2002 at 07:17:05PM -0700, Irwan Hadi wrote:
> Dear All,
> 
> I just curious (since I haven't tried this), what happened to linux (the
> kernel especially), when a Linux Box has for example 100 access lists,
> 500 access lists, 1000 access lists, etc ?
> Will I see a process consuming 100% of CPU Resources, or people will
> feeling much slower when they are accessing my server, or the box starts
> dropping some packets ?
> 
> (what I meant access lists is the TCP filtering managed thru ipchains,
> iptables, etc.)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
      Teodor Iacob,
Astral TELECOM Internet

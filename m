Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbRFGWEw>; Thu, 7 Jun 2001 18:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263347AbRFGWEm>; Thu, 7 Jun 2001 18:04:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:21259 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263445AbRFGWEb>; Thu, 7 Jun 2001 18:04:31 -0400
Date: Thu, 7 Jun 2001 17:29:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Shane Nay <shane@minirl.com>
Cc: "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <0106071455511D.32519@compiler>
Message-ID: <Pine.LNX.4.21.0106071722450.1156-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Jun 2001, Shane Nay wrote:

> On Thursday 07 June 2001 13:00, Marcelo Tosatti wrote:
> > On Thu, 7 Jun 2001, Shane Nay wrote:
> > > (Oh, BTW, I really appreciate the work that people have done on the VM,
> > > but folks that are just talking..., well, think clearly before you impact
> > > other people that are writing code.)
> >
> > If all the people talking were reporting results we would be really happy.
> >
> > Seriously, we really lack VM reports.
> 
> Okay, I've had some problems with the VM on my machine, what is the most 
> usefull way to compile reports for you?  

1) Describe what you're running. (your workload)
2) Describe what you're feeling. (eg "interactivity is crap when I run
this or that thing", etc) 

If we need more info than that I'll request in private. 

Also send this reports to the linux-mm list, so other VM hackers can also
get those reports and we avoid traffic on lk.

> I have modified the kernel for a few different ports fixing bugs, and
> device drivers, etc., but the VM is all greek to me, I can just see
> that caching is hyper aggressive and doesn't look like it's going back
> to the pool..., which results in sluggish performance.

By performance you mean interactivity or throughput? 

> Now I know from the work that I've done that anecdotal information is
> almost never even remotely usefull.  

If we need more info, we will request. 

> Therefore is there any body of information that I can read up on to
> create a usefull set of data points for you or other VM hackers to
> look at?  (Or maybe some report in the past that you thought was
> especially usefull?)

Just do what I described above. 

Thanks


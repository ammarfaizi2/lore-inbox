Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317811AbSHHXfu>; Thu, 8 Aug 2002 19:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318078AbSHHXft>; Thu, 8 Aug 2002 19:35:49 -0400
Received: from web40005.mail.yahoo.com ([66.218.78.23]:3688 "HELO
	web40005.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317811AbSHHXft>; Thu, 8 Aug 2002 19:35:49 -0400
Message-ID: <20020808233926.14381.qmail@web40005.mail.yahoo.com>
Date: Thu, 8 Aug 2002 16:39:26 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: What patches I need for s stable 2.5.x
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1028846060.28882.105.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Cox,

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Thu, 2002-08-08 at 22:02, Brad Chapman wrote:
> > Everyone,
> > 
> >       I have been following some of the threads on linux-kernel and have
> read
> > about the IDE problems. I know about Jens' 2.4.x IDE foreport, and I was 
> > wondering: what other patches should I apply, besides the 2.4.x IDE
> foreport,
> > to ensure a stable 2.5.x kernel?
> 
> The IDE stuff might get you a usable 2.5, even then the error handling
> is not correct in all cases so treat it with care. On my test boxes the
> foreport didnt hang the machine the way 2.5.* did so its an improvement.
> You might just want to follow the 2.5.*-dj tree though
>

        ACK. Are there any gotchas associated with the 2.5.x-dj tree? I 
haven't really studied it up to this point.

Brad 


=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
		   tanami_croc@devel.lbsd.net

__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290983AbSCGV1C>; Thu, 7 Mar 2002 16:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285692AbSCGV0w>; Thu, 7 Mar 2002 16:26:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7940 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290983AbSCGVZb>;
	Thu, 7 Mar 2002 16:25:31 -0500
Message-ID: <3C87DA57.1B6CFC22@zip.com.au>
Date: Thu, 07 Mar 2002 13:23:35 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Troy Benjegerdes <hozer@drgw.net>
CC: Pavel Machek <pavel@ucw.cz>, Larry McVoy <lm@work.bitmover.com>,
        Kent Borg <kentborg@borg.org>,
        The Open Source Club at The Ohio State University 
	<opensource-admin@cis.ohio-state.edu>,
        linux-kernel@vger.kernel.org, opensource@cis.ohio-state.edu
Subject: Re: Petition Against Official Endorsement of BitKeeper by Linux 
 Maintainers
In-Reply-To: <20020305165233.A28212@fireball.zosima.org> <20020305163809.D1682@altus.drgw.net> <20020305165123.V12235@work.bitmover.com> <20020306095434.B6599@borg.org> <20020306085646.F15303@work.bitmover.com> <20020306221305.GA370@elf.ucw.cz>, <20020306221305.GA370@elf.ucw.cz>; <20020307101701.S1682@altus.drgw.net> <3C87C583.C8565E4B@zip.com.au>,
		<3C87C583.C8565E4B@zip.com.au>; from akpm@zip.com.au on Thu, Mar 07, 2002 at 11:54:43AM -0800 <20020307145031.V1682@altus.drgw.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Troy Benjegerdes wrote:
> 
> On Thu, Mar 07, 2002 at 11:54:43AM -0800, Andrew Morton wrote:
> > Troy Benjegerdes wrote:
> > >
> > > I'd really like everyone that's bitching about BK to shut the hell up and
> > > go work on some scripts to allow a maintainer to easily manage a
> > > BK<->$OTHER_SCM gateway.
> >
> > ie: "We broke it.  You fix it".
> >
> > It's not reasonable to expect people who shall not be using bitkeeper
> > to go off and perform enhancements to bitkeeper so that they can
> > continue to be effective kernel developers.
> 
> No. Try:
> "You're whining, here's how fix it, because I don't have time or
> motivation"

Let's be clearer:

- If bitkeeper makes non-bitkeeper developers less effective than
  they traditionally have been then Larry gets to fix that.

- If non-bitkeeper users want *additional* functionality over what
  has traditionally been available then they get to implement it.

And Linus will keep pushing prepatches in the time-honoured
manner, so there's no loss in non-bk users effectiveness.

> Larry went to a lot of trouble to listen to what kernel developers
> wanted, and a lot of work to implement some of it. I expect same courtesy
> of everyone who is complaining.

I don't think anyone has been criticising bk featureset or reliability.
A few performance mumblings, maybe. It seems to be a fantastic piece
of software.

But that's not the point!   Nobody, repeat nobody is happy with the
licensing thing.  For some people, the day-to-day benefits outweigh
the philosophical concerns.  For others they do not.  That is what is
being discussed here.

I see two things being discussed here:

1: I don't want bitkeeper use to *decrease* my ability to do Linux
   work.  Linus will continue to push patches at the same rate, so
   I have no problem.  I'm OK with others using bitkeeper.  EOT.

2: Kernel has a leading role in free software development. Other
   people do not want kernel's use of bitkeeper to weaken that
   movement.

   Me, I don't think the "movement" is weak enough for damage to
   come about.  And SCM is a space where the free tools are weak.  
   It's a once-off special-case and it's hard to see how anything
   bad will come about from it.

> If Larry can make good on his 'threat' to write a read-only cvs pserver
> interface to BK, I think he's done his part. (BK -> $OTHER_SCM)

Well that would be icing on the cake.  But I don't believe it's
reasonable to expect bitmover to provide non-bitkeeper users
with *more* stuff than they have traditionally had.

That being said, the adoption of bitkeeper does reduce the
chances of non-bitkeeper users from ever getting more features,
but realistically, that would never have happened anyway.

And the non-bitkeeper users *do* have more than they used to
have - the web logs and changelogs.  That's nice.  It'd be
nicer if the web interface was more up-to-date, but I am told
that's a person thing, not a tool thing.

-

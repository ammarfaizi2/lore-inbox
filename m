Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288983AbSAZBf2>; Fri, 25 Jan 2002 20:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288982AbSAZBfO>; Fri, 25 Jan 2002 20:35:14 -0500
Received: from svr3.applink.net ([206.50.88.3]:13325 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S288975AbSAZBfA>;
	Fri, 25 Jan 2002 20:35:00 -0500
Message-Id: <200201260132.g0Q1W4L13063@home.ashavan.org.>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: kaih@khms.westfalen.de (Kai Henningsen), linux-kernel@vger.kernel.org
Subject: Re: RFC: booleans and the kernel
Date: Sat, 26 Jan 2002 19:33:15 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <8HXjQ8omw-B@khms.westfalen.de> <200201250900.g0P8xoL10082@home.ashavan.org.> <8HYG7RLmw-B@khms.westfalen.de>
In-Reply-To: <8HYG7RLmw-B@khms.westfalen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 January 2002 13:02, Kai Henningsen wrote:
> timothy.covell@ashavan.org (Timothy Covell)  wrote on 26.01.02 in 
<200201250900.g0P8xoL10082@home.ashavan.org.>:
> > On Friday 25 January 2002 00:36, Kai Henningsen wrote:
> > > We're talking about a specific language feature, and that feature isn't
> > > what you seem to be thinking it is. It does not change anything you can
> > > do with ints.
> >
> > I know, I was talking about typographical errors such as:
> >
> > int x=0;
> >
> > if ( x = 1 )
> >
> >
> > or
> >
> > char x;
> > if ( x )
> >
> > which did not product the desired results.  My thought was to encourage
> > the use of booleans instead of ints in these kinds of conditionals.   I
> > thought
>
> And if you changed the int and/or the char into bool, this would
> accomplish exactly nothing. A compiler can warn about assignments in
> conditions or uninitialized variables, and gcc does it already (and has
> done so since a long time); why you think this has anything to do with
> bool seems to be completely unclear to everyone but you.
>
> > admits that there are benefits too.  But, I think it amazing that I'm
> > being told that I'm an idiot when even the language's author agrees with
> > me on my concerns about C.
>
> Of course, that is again not what is happening. You either *weren't*
> talking about Richie's concerns, or else you were making an excellent
> effort of keeping that fact secret from the rest of us.
>
> What you *were* saying is that you think bool would help get warnings that
> you *already* get and that bool has absolutely no relevance to. I didn't
> exactly call you an idiot for that, but that is certainly the impression
> you left.


You know, I used to wonder why more people didn't like/use Linux.  Now,
after a month or so of reading this website and meeting so many arrogant 
assholes, now I know why.    I think that Tannebaum was right, it's amazing 
that Linus can get such a rag-tag group of "prima donnas" to accomplish 
anything. Of course, it looks like he does it by just looking at the code and 
ignoring the people behind it.

I, on the other hand, do not do that.  I don't use Microsoft because I think 
the company is morally bankrupt.   And now, you and you ilk have convinced 
me to stop lauding Linux.  There are other OSes out there to use, many which 
are both technically and operationally superior and definitely come without
your bad attitude.


----
timothy.covell@ashavan.org.

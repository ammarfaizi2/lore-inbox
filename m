Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315166AbSDWLe2>; Tue, 23 Apr 2002 07:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315167AbSDWLe1>; Tue, 23 Apr 2002 07:34:27 -0400
Received: from dsl-213-023-038-128.arcor-ip.net ([213.23.38.128]:59042 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315166AbSDWLe0>;
	Tue, 23 Apr 2002 07:34:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andre Pang <ozone@algorithm.com.au>, linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
Date: Mon, 22 Apr 2002 13:34:34 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020422131011.D6638@havoc.gtf.org> <E16zLsy-0001Is-00@starship> <1019537823.310634.29598.nullmailer@bozar.algorithm.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16zc5a-0001Sb-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 April 2002 06:57, Andre Pang wrote:
> On Sun, Apr 21, 2002 at 08:16:28PM +0200, Daniel Phillips wrote:
>     11. Pulling BK doc in the tree would make less users aware of
> 	BK and thus solve most of these problems

Brilliant summary, up to point 11.  A url to the 'Using Bitkeeper with
Linux' docs/scripts would stay in the tree, perhaps in the
SubmittingPatches file, so there is no attempt to cut down BK usage
by hiding documentation.  There is an attempt to keep the tree free of
commercial advertising, and no I am *not* going to go attack what you
or anyone else perceives as a problem with ReiserFS.  Anybody who is
concerned about that can speak for themselves.

> So, what are the problems that can be solved?  Perhaps adding
> some lines to the BitKeeper doc saying "Unless your patch is
> trivial, please post it to linux-kernel for peer review, because
> this is one of the great strengths of open-source software" would
> be a good idea.

Yes, that would help.

> Supply a shell script in the BK docs which generates a diff-style
> patch and send that off to LKML if you update a BK tree.

Too much 'automatic' traffic for lkml, however something similar is
being worked on by the patchbot group.

> Add that patch which was floating around earlier in the thread
> saying that BK is non-free, and that it is only one alternative
> for doing things.

Yes.

> Or maybe set up another separate mailing list (e.g.
> linux-bk-updates), run by a bot which emails that list whenever
> a patch to a BK tree is submitted.  People who don't use BK, such
> as yourself, can subscribe to the list and initiate discussion on
> such patches by bringing the mail to linux-kernel.

Right, linux-patches, with a view to providing notification of
*proposed* patches before they become formally part of a tree.

> BK is here to stay; no doubt about that.  Doing something
> completely controversial like removing the docs for it is not the
> way to go if you want to solve the problems that it has created.
> I think it's good that you vocalised the problems with using BK,
> but you're going about fixing the symptoms in the wrong way.

Probably.  A deeper fix is needed, indeed.

> I'm sure people (Jeff and Larry, in particular) would be much
> more happy if you addressed those issues by adding things to the
> BK docs highlighting the problems that it causes, and include
> ways of fixing them.  You say that you're not anti-BK, and
> I believe you're not, but your actions are indicating otherwise.

Sorry, I am anti-bitkeeper now; two days ago I was not.

I now believe that the move to BitKeeper constitutes a creeping
takeover of the means of developing linux by commercial interests.
I did not believe that going in, but went out of his way to convince
me of it.  I should have realized earlier, during the period in
which Larry was putting considerable energy into discrediting and
discouraging the Arch project, and Subversion for that matter.

I now firmly believe that we must have our own tools, and that we are
in a transitory period where we are using proprietary tools because
free ones are not available.  So the path forward is to build the
tools we need, or join with others to build them.  That's the path I'm
taking.  I will not suggest that anyone stop using BitKeeper, and
especially, I will not advocate that Linus stop using BitKeeper.  We
need the efficiency, and until there is a functional replacement,
BitKeeper is the only game in town.

> BK is not the problem: BK is a new way of working with Linus,
> which is causing problems for people who are used to the non-BK
> way of working with him.  Fix that problem, not BK itself.

Thanks for your advice.

Hopefully this is the end of the thread.

-- 
Daniel

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290891AbSAaDho>; Wed, 30 Jan 2002 22:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290888AbSAaDhe>; Wed, 30 Jan 2002 22:37:34 -0500
Received: from dsl-213-023-038-145.arcor-ip.net ([213.23.38.145]:11673 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290882AbSAaDhO>;
	Wed, 30 Jan 2002 22:37:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rob Landley <landley@trommello.org>,
        Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        "Matthew D. Pitts" <mpitts@suite224.net>,
        "Chris Ricker" <kaboom@gatech.edu>,
        "Linus Torvalds" <torvalds@transmeta.com>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Thu, 31 Jan 2002 04:40:31 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "World Domination Now!" <linux-kernel@vger.kernel.org>
In-Reply-To: <200201302239.QAA39272@tomcat.admin.navo.hpc.mil> <E16W783-0000KD-00@starship.berlin> <20020131032832.KJVO14927.femail22.sdc1.sfba.home.com@there>
In-Reply-To: <20020131032832.KJVO14927.femail22.sdc1.sfba.home.com@there>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16W85P-0000Kc-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 31, 2002 04:29 am, Rob Landley wrote:
> On Wednesday 30 January 2002 09:39 pm, Daniel Phillips wrote:
> > On January 30, 2002 11:39 pm, Jesse Pollard wrote:
> > > Linus has announced who he accepts patches frin, and who will be doing
> > > the 2.0, 2.2, and 2.4 maintenance. It would seem logical to have those
> > > lieutenants announce their maintainers.
> >
> > Logical flaw: Marcelo is the maintainer of 2.4, Linus is the maintainer of
> > 2.5, does it make sense for Marcelo to announce the maintainer of usb for
> > 2.4?
> >
> > It's not as simple as you'd think.  Reason: it's not a tree, it's an
> > acyclic graph.  Hopefully.  ;-)
> 
> I'm still trying to figure out who all the lieutenants are.

You will never figure that out, it isn't predefined.  It reshapes itself on the
fly, and is really defined by what is going on at any given time.  That said,
it's usually possible to figure out how the main maintainers are, and what to
send where, just don't hope to ever nail that down in a rigid structure.  It's
not rigid.

> (It seems Andre 
> Hedrick reports to Jens Axboe, Rik van Riel might actually report to.. Andrea 
> Arcangeli?  (Or Dave Jones.)  But who does Eric send his help patches to?  Is 
> Kieth Owens at the top level or what?  It seems like both Kieth and Eric are 
> also under Dave Jones.  I guess "patch penguin" is just "Miscelaneous 
> Lieutenant".  Makes sense i the new context, I suppose...)
> 
> I expect it will all get worked out eventually.  Now that the secret of the 
> difference between maintainers and lieutenants is out.

By the way, that never was a secret to anybody in active development.

> The thread seems to be dying down a bit... :)

Right, people are working on solutions.  As usual, though much dung did fly,
Linus comes out smelling like a rose.

-- 
Daniel

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290884AbSAaD2w>; Wed, 30 Jan 2002 22:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290887AbSAaD2n>; Wed, 30 Jan 2002 22:28:43 -0500
Received: from femail22.sdc1.sfba.home.com ([24.0.95.147]:45790 "EHLO
	femail22.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S290884AbSAaD2c>; Wed, 30 Jan 2002 22:28:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        "Matthew D. Pitts" <mpitts@suite224.net>,
        "Chris Ricker" <kaboom@gatech.edu>,
        "Linus Torvalds" <torvalds@transmeta.com>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Wed, 30 Jan 2002 22:29:39 -0500
X-Mailer: KMail [version 1.3.1]
Cc: "World Domination Now!" <linux-kernel@vger.kernel.org>
In-Reply-To: <200201302239.QAA39272@tomcat.admin.navo.hpc.mil> <E16W783-0000KD-00@starship.berlin>
In-Reply-To: <E16W783-0000KD-00@starship.berlin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020131032832.KJVO14927.femail22.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 January 2002 09:39 pm, Daniel Phillips wrote:
> On January 30, 2002 11:39 pm, Jesse Pollard wrote:
> > Linus has announced who he accepts patches frin, and who will be doing
> > the 2.0, 2.2, and 2.4 maintenance. It would seem logical to have those
> > lieutenants announce their maintainers.
>
> Logical flaw: Marcelo is the maintainer of 2.4, Linus is the maintainer of
> 2.5, does it make sense for Marcelo to announce the maintainer of usb for
> 2.4?
>
> It's not as simple as you'd think.  Reason: it's not a tree, it's an
> acyclic graph.  Hopefully.  ;-)

I'm still trying to figure out who all the lieutenants are.  (It seems Andre 
Hedrick reports to Jens Axboe, Rik van Riel might actually report to.. Andrea 
Arcangeli?  (Or Dave Jones.)  But who does Eric send his help patches to?  Is 
Kieth Owens at the top level or what?  It seems like both Kieth and Eric are 
also under Dave Jones.  I guess "patch penguin" is just "Miscelaneous 
Lieutenant".  Makes sense i the new context, I suppose...)

I expect it will all get worked out eventually.  Now that the secret of the 
difference between maintainers and lieutenants is out.  The thread seems to 
be dying down a bit... :)

Rob

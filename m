Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280307AbRKIXai>; Fri, 9 Nov 2001 18:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280293AbRKIXa2>; Fri, 9 Nov 2001 18:30:28 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:54666 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S280305AbRKIXaS>;
	Fri, 9 Nov 2001 18:30:18 -0500
Date: Fri, 9 Nov 2001 18:30:18 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Robert Love <rml@tech9.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Any lingering Athlon bugs in Kernel 2.4.14?
In-Reply-To: <1005247097.866.41.camel@phantasy>
Message-ID: <Pine.LNX.4.30.0111091828570.17281-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


They get random NULL pointer dereference attempts from the kernel, as well
as some messages relating to errors in virtual page blah blah blah.
Really I should write down the error messages.. but basically the system
prints what looks like a black screen of death to the console and then
becomes completely non-responsive.


On 8 Nov 2001, Robert Love
wrote:

> On Thu, 2001-11-08 at 13:17, Calin A. Culianu wrote:
> > I wouldn't mind trying his tree at all.  Does his tree somehow use the
> > older VM, or does it try to address Athlon bugs more aggressively? Ie: Why
> > is this a great idea?  (Apart from Alan's tree just being really cool).
>
> It does use the older VM, and more importantly it has some odd end fixes
> that have yet to be incorporated into Linus's tree.  And, yes, it is
> just really cool :)
>
> After that, I would look into compiling without optimization.
>
> Also, what exactly happens on the systems?  Do they hard lock?  Do you
> have an oops?
>
> 	Robert Love
>


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbSKTGO1>; Wed, 20 Nov 2002 01:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbSKTGO1>; Wed, 20 Nov 2002 01:14:27 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:6661 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265786AbSKTGOZ>; Wed, 20 Nov 2002 01:14:25 -0500
Date: Tue, 19 Nov 2002 22:21:16 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jeff Garzik <jgarzik@pobox.com>, Eben Moglen <moglen@columbia.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spinlocks, the GPL, and binary-only modules
In-Reply-To: <3DDAB6AD.4050400@pobox.com>
Message-ID: <Pine.LNX.4.10.10211192102490.1342-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greeting Jeff and Eben,

Eben, if I understand you are presently or in the past the general council
for FSF arguments and legal briefs, would you be kind enough to set a
legal position of the nature of headers in any environment.  I would have
#include RMS but his position is known, and may have violated a license.

Now the joke is over, but it has significant implications now.

Soon the question will be raised and either you or somebody else will be
called to answer and justify the point.  So please send me a quote for the
estimated cost of a legal brief on the specifics related to the content
below.  If I can afford it, I will pay for it to begin the process of
setting the legal guides of usage of binary only drivers which only use
the headers of a given kernel.

Given the context of embedded software based on GPL, VAR appliance
builders, large|mid|small cap companies, individuals, etc... who are using
and improving the quality of entire package because it benefits them to do
so and it is the right thing to do.

So the issue come down to the following:

Will the few idealist in the world who dream the impossible, make it
impossible to for the realist whom are trying to follow but have to make
money to justify the goal.  There appears to be a push to kill the dream
by forcing the folks who believe in the goals but now will have to justify
their position and risk.  If the risk of litigation becomes to high, even
for those who follow the rules and promote compliance to rules set forth
in the past, people will adopt another environment.

Now we are in quite a dangerous position presently, as the strength and
maturity of the Linux Community of Contributors rises to the what everyone
knew it could be, to have find out it is a house of cards build on sand 
and not pilars of stone set on bedrock.

I have already carpet bombed the mailing list in sheer anger.

Now it is time to put the rubber on the road, and it costs money.
So again I do not have an endless pile of money to do it alone, but I have
to risk it all now including a potential for personal bankruptecy, if I
stand a chance to help keep the dream alive.  Please provide me a quote
for the brief and the estimated time to complete.


Sincerely,

Andre Hedrick
LAD Storage Consulting Group

I apologize if it is not clear, as I am trying to not mix words.

On Tue, 19 Nov 2002, Jeff Garzik wrote:

> blah.
> 
> So, since spinlocks and semaphores are (a) inline and #included into 
> your code, and (b) required for just about sane interoperation with Linux...
> 
> does this mean that all binary-only modules that #include kernel code 
> such as spinlocks are violating the GPL?  IOW just about every binary 
> module out there, I would think...
> 
> I'm sure this would make extremeists happy, but I personally don't mind 
> binary-only modules as long as the binary-only code [ignoring the 
> #included kernel code] cannot be considered a derived work.
> 
> But who knows if #include'd code constitutes a derived work :(
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313566AbSDUQdC>; Sun, 21 Apr 2002 12:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313567AbSDUQdB>; Sun, 21 Apr 2002 12:33:01 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:58271 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313566AbSDUQc6>;
	Sun, 21 Apr 2002 12:32:58 -0400
Date: Sun, 21 Apr 2002 12:32:57 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020421123257.A4479@havoc.gtf.org>
In-Reply-To: <E16ya3u-0000RG-00@starship> <20020420115233.A617@havoc.gtf.org> <3CC19470.ACE2EFA1@linux-m68k.org> <20020420122541.B2093@havoc.gtf.org> <3CC1A31B.AC03136D@linux-m68k.org> <20020420170348.A14186@havoc.gtf.org> <3CC201F7.B3AC3FDF@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 02:04:07AM +0200, Roman Zippel wrote:
> Hi,
> 
> Jeff Garzik wrote:
> 
> > What was Daniel's action?  Remove the text.  Nothing else.  Sure, he
> > suggested other options, but he did attempt to implement them?  No.
> > He just implied that people need to step up and do this work for him.
> 
> He made his intention very clear, you are interpreting something in his
> action, that simply isn't there.

How can one misinterpret the action of "<this> is my ideology.
this document offends me.  I remove it."?


> > Daniel attempted to remove speech he disgreed with from wide
> > distribution -- on distro CDs, kernel.org mirrors, etc.  I am hoping
> > it is plainly obvious that removing a doc from one of the mostly
> > widely distributed open source projects reduces the doc's distribution
> > dramatically.  _That_ is a form of censorship, just like buying out
> > printing presses, to silence them, in the old days.  It's still
> > around... just progressively harder to obtain.
> 
> Censorship requires the means to enforce it and has Daniel this ability?
> Could we please stop these "censorship" and "ideology" arguments? In
> this context they are simply nonsense.

Ideology was the __sole__ reason for removing the document.

Since Linus uses BK, and the document is there in the first place
to make life easier, Daniel is therefore making life more difficult
because of ideology, and no other reason.

If you want to be really semantic, Daniel's patch was an attempt to
censor, not censorship itself.  But when it's a GPL'd document that
I wrote, I'll treat them equally.



> kernel development with bk requires net access

No it doesn't


> when it's available over the net. On the other hand SubmittingPatches
> describes the lowest common denominator, which works with any SCM and
> doesn't favour any of them.
> Personally I don't care what tools people use, but I'm getting
> concerned, when a nonfree tool is advertised as tool of choice for
> kernel for development as if there would be no choice.

Linus, myself, and others _repeatedly_ say that BitKeeper is _not_
the sole means of submitting patches.  Thus actively and repeatedly
disputing "as if there would be no choice."

This policy of supporting GNU patches has been in existence since
time began, and absolutely nothing has changed in that regard.

To imply otherwise is to spread Fear, Uncertainty, and Doubt.


> bk has advantages
> for distributed development, but beside of this they are alternatives
> and we should rather encourage users to try them and to help with the
> development of them.

How many users here, besides me, have actually done serious patching of
the CVS source?  The argument that kernel developers will help develop
an SCM is admirable, but unrealistic IMO.  Otherwise, kernel hackers
would have written a BK alternative by now, instead of simply whining.


> But there isn't anything like that, so Joe Hacker
> has to think he should use bk as SCM to get his patch into the kernel,
> because Linus is using it.

If Linus and others repeatedly claim this is untrue, and repeatedly
prove this by taking GNU patches, your statement is utter fantasy.

	Jeff



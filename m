Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288276AbSA3Dp1>; Tue, 29 Jan 2002 22:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288342AbSA3DpI>; Tue, 29 Jan 2002 22:45:08 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:18579
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288276AbSA3DpD>; Tue, 29 Jan 2002 22:45:03 -0500
Message-Id: <200201300344.g0U3i5U24616@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Jeff Garzik <garzik@havoc.gtf.org>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 22:45:14 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201282217220.10929-100000@penguin.transmeta.com> <200201300131.g0U1VsU22963@snark.thyrsus.com> <20020129204617.A16318@havoc.gtf.org>
In-Reply-To: <20020129204617.A16318@havoc.gtf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 January 2002 08:46 pm, Jeff Garzik wrote:
> On Tue, Jan 29, 2002 at 08:33:03PM -0500, Rob Landley wrote:

> > Of course this still doesn't address the problem of patches going stale
> > if they're not applied for a version or two and something else that goes
> > in breaks them...
>
> If you really want to be a patch penguin then.... just do it.
>
> You don't need specific permission to pick up, update, and maintain
> patches that don't make it into the Linus tree on the first try.

I'm not asking to become a patch penguin, and the various other people who 
volunteered early on, though well intentioned, slightly missed my point as 
well.

We used to HAVE a patch penguin.  "Miscelaneous maintainer", "integration 
lieutenant", call the position what you will.  His name was Alan Cox.  He 
recently abdicated the position, which has since gradually been assumed by 
Dave Jones.  There is serious pressure on Dave Jones's tree to accept the 
kind of patches Alan used to (and which Alan is still accepting for 2.4 and 
queuing for Marcelo).  If Dave continues to put out a tree, he would have to 
work fairly hard to avoid becoming Alan Cox's successor.

I was hoping for some sort of indication that if patches DID get into Dave's 
tree, it would be a step towards their eventual consideration by Linus.  Not 
a guarantee of inclusion, of course, but it would be nice to know if 
inclusion in Dave's tree would move the patch one step towards Linus, or 
would just head down a cul-de-sac and additional fragmentation of the 
development process.

I was also trying to point out that there seems to be a recurring role here, 
which used to be identified with "just Alan" but has now passed to another 
person, while still maintaining a noticeable portion of its character.  It 
might be nice to recognize it as such.

Also, I was trying to encourage ONE beta tree in order to DISCOURAGE the 
fragmented proliferation of version-skewed trees accepting third party 
patches that seem to have been cropping up recently.  (See the linux weekly 
news and kernel traffic links in the original posting that started this whole 
thread.)  In the absence of an -ac tree to accept patches that show 
significant promise but are not ready for Linus and vice versa, patches are 
accumulating in multiple trees.  This fragments the tester base, and seemed 
to me to be a less efficient way than the way things worked before Alan quit.

There seems to have been widespread misinterpretation of these objectives...

> 	Jeff

Rob

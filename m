Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVBKPba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVBKPba (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 10:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVBKPba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 10:31:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8347 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262257AbVBKPap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 10:30:45 -0500
To: lm@bitmover.com (Larry McVoy)
Cc: Stelian Pop <stelian@popies.net>, Francois Romieu <romieu@fr.zoreil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
References: <20050204201157.GN27707@bitmover.com>
	<20050204214015.GF5028@deep-space-9.dsnet>
	<20050204233153.GA28731@electric-eye.fr.zoreil.com>
	<20050205193848.GH5028@deep-space-9.dsnet>
	<20050205233841.GA20875@bitmover.com>
	<20050208154343.GH3537@crusoe.alcove-fr>
	<20050208155845.GB14505@bitmover.com>
	<ord5vatdph.fsf@livre.redhat.lsd.ic.unicamp.br>
	<20050209155113.GA10659@bitmover.com>
	<or7jlgpxio.fsf@livre.redhat.lsd.ic.unicamp.br>
	<20050210211700.GA26361@bitmover.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 11 Feb 2005 13:30:22 -0200
In-Reply-To: <20050210211700.GA26361@bitmover.com>
Message-ID: <or1xbn6rn5.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 10, 2005, lm@bitmover.com (Larry McVoy) wrote:

> It seems like you've made up your mind that we are operating out of pure
> self interest and have no desire to help you or anyone else unless we
> get something out of it.  In other words, we're making our decisions
> based on the net positive/negative effect on our business.

> Is that a fair assessment of your position?  

It sounds like a reasonable assessment, although your wording can be
read as if I meant that in a negative way.  AFAIK a publicly-traded
company (which I believe is not your case, but anyhow) is *required*
to behave like that.  I actually expect most businesses to behave
like.  It's not a judgment, a good vs evil thing.  I actually think
you made a very clever move, and if it wasn't for self benefit, you're
very lucky :-)

> It's clear that the path we took has generated illwill amongst some of
> you

Those of us who are religious about Free Software (myself included)
can't help being upset because one of the most visible Free Software
packages relies on proprietary software for an important part of its
development process, and even more so because of the lock-in tactics
played by their developers.

> So if we knew that doing this would hurt our business, which according
> you is the only thing we care about, then why would we do it?

I think you correctly assessed the situation and decided to take the
risk that, in spite of the negative reactions you'd get, you'd still
get good visibility, a very important showcase, and a number of happy
users that would be willing to recommend your software to others who
might be looking for a VCS.

People who are happy with what they get seldom make their feelings
noisily public; those that are unhappy are more likely to make a fuss
out of it.  This is just human nature.

In spite of a bit of negative publicity, you're still better off, even
after taking into account all of the costs you incur because of the
involvement with Linux.

> Is it your opinion that the postive marketing we get outweighs the
> negative?

I do believe so, yes.  The fact that one of the most representative
Open Source projects chose BK, in spite of BK being proprietary,
sounds like a very powerful claim to me.

> If you are willing to believe that we have good good enough management
> here that we were aware of this, and we added up the illwill and the IP
> risk and did it anyway.  Why?  Why would any business do something that
> was obviously a poor business decision?  Please don't take the cheap
> shot and say we are idiots, the founder of your company has advised us
> from day one as have others.  We knew what we were doing.  

I don't think you are idiots.  I actually admire your bold move, and
think it was a very clever one.  But that doesn't make me happy about
it, because BK is not Free Software, and I, who prefer to use only
Free Software, am denied access to information that is available to
others that don't feel that strongly (or at all) about this matter.

> Can you offer any plausible explanation other than a good faith desire
> to help the open source community, albeit in a non-traditional way?

I don't see what you've done as helping the open source community.  I
think the use of BK undermines the bottom line of promoting Free
Software and living by what we promote.  It is embarrassing to me to
admit that Linux uses BK as a VCS, just like it is embarrassing to
admit that Red Hat uses proprietary software from Oracle, just like it
is embarrassing to admit that I had to use an MS-Windows box to
perform services for a Red Hat customer shortly after I joined Red
Hat, after almost 10 years without using MS-DOS or MS-Windows.  None
of these bode well to the message I try to spread when I talk about
Free Software.

> You are saying we are an evil money grubbing corporation because we
> don't want to give our technology to our competitors.

I'm not saying that.  I'm saying you're a clever corporation who are
promoting your bottom line by providing services and tools to an Open
Source project, and I'm grateful for that, especially for the CVS
gateway, but unfortunately you're also hurting the Free Software
bottom line by having got Linux into a lock-in position.

I'm not concerned in any way that you don't want to give your
technology to your competitors.  I don't want your technology, since
it's proprietary.  I'd just like to have access to the information
about Linux that your technology is intentionally hiding from me.


The bit I don't understand is that you've claimed you'd be willing to
implement the code needed to export the additional information that
Roman, myself and probably many others would like to have, if someone
would pay for that, but you're not willing to grant him access to this
information such that he can write the code himself.  How come you
wouldn't welcome a BK-export piece of software that you could use
yourself to create and maintain the CVS tree, without having to
develop and maintain the software, and insist on developing such
software yourself, but only if someone else pays for it?

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}

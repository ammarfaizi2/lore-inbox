Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTLUKda (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 05:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTLUKda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 05:33:30 -0500
Received: from mail.shareable.org ([81.29.64.88]:35719 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262564AbTLUKd1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 05:33:27 -0500
Date: Sun, 21 Dec 2003 10:33:08 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Lennert Buytenhek <buytenh@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: [OT] use of patented algorithms in the kernel ok or not?
Message-ID: <20031221103308.GB3438@mail.shareable.org>
References: <20031218231137.GA13652@gnu.org> <1071823624.5223.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071823624.5223.1.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Fri, 2003-12-19 at 00:11, Lennert Buytenhek wrote:
> > However, I am aware that there is a patent on this algorithm, exclusively
> > licensed to a major manufacturer of networking equipment.
> 
> a patent in which country ?
> 
> Maybe we need a CONFIG_USA so that we can enhance the kernel for
> non-unitedstatians while keeping it safe to run in that one country with
> the patents as well.

Seriously, I am working on code which would potentially infringe a
good number of patents in the USA, if it were used there, but I do not
know which ones.  It is a guess.

Where I live most of those patents are not relevant.  So I do not make
a point of studying them.  I do not live or work in the USA, and my
code is more useful to people in the rest of the world anyway.  But I
would still like to share it without bias to people in all countries.

One or two of the patents may be relevant due to a problem of
ambiguity from allegedly illegally granted patents in the country
where I live.  Even if those patents in this country could be shown to
be invalid (not the same as illegal), I am not large enough
economically (i.e. I'm a small business, not a large business) to
afford the risk or legal costs of assuming that.  Therefore I must
hope for some clarity in the law here regarding their illegality,
which may come.

I know that equivalent code, which is covered by most if not all of
the patents, is sold by some software companies to product developers
_in the USA_ without prelicensed patents.  The problem of acquiring
suitable patent licenses is left to the purchasers.

Rationally I would expect that if someone is able to sell code and
leave the problem of patent licensing to the purchaser, then one
should be able to _give away_ code and leave the problem of patent
licensing to the recipient.

Yet it is clear from a million threads like this one that giving away
code freely is feared to be patent infringement even when selling it
under restrictive licensing is not.

There is a horrible dichotomy in this picture, and I'm not sure what
to do about it.  Stopping innovating due to fear of potential patent
litigation does not seem like a right thing to do.  Switching to a
closed-source model because that removes one from liability does not
seem like a right thing either.

I would be really pleased if someone were able to show that
distributing code in a disabled form, for example using something like
CONFIG_USA which you mentioned, or something which requires more
expertise to change, placed liabilities for enabling and using the
code upon the person who does the enabling, and not the original
author or distributor of the code.

Is there any USA-based precedent to that effect?  Perhaps that's even
the norm and I have not understood how things work there?

Thanks,
-- Jamie

Return-Path: <linux-kernel-owner+w=401wt.eu-S1754709AbWLRWfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbWLRWfY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 17:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754712AbWLRWfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 17:35:23 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:32640 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709AbWLRWfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 17:35:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r3AOS8MYyNPwFvIvV3HMuxGUdhEV2Oa0fjc7q9I9QDs01wcSGRlDoZhMAYosXqmyfMVOMaCZaNTAOl8gffeaO4BZ2tfnUxup6h0XmvunpTPeFWmcxlcTPTblMKJkQKUqIFDpZU6bO4tCNO55StQp53jGerER5z8wqCCEfa1Wzrc=
Message-ID: <7b69d1470612181435s505282f0r7c9c47d554f87ecf@mail.gmail.com>
Date: Mon, 18 Dec 2006 16:35:19 -0600
From: "Scott Preece" <sepreece@gmail.com>
To: davids@webmaster.com
Subject: Re: GPL only modules
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKKEDMAHAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612181242530.3479@woody.osdl.org>
	 <MDEHLPKNGKAHNMBLJOLKKEDMAHAC.davids@webmaster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/06, David Schwartz <davids@webmaster.com> wrote:
>
> > Static vs dynamic matters for whether it's an AGGREGATE work. Clearly,
> > static linking aggregates the library with the other program in the same
> > binary. There's no question about that. And that _does_ have meaning from
> > a copyright law angle, since if you don't have permission to ship
> > aggregate works under the license, then you can't ship said binary. It's
> > just a non-issue in the specific case of the GPLv2.
>
> The right to ship aggregate works is not one specifically reserved by law to
> the copyright holder.
---
Well, it's reserved to the authors of all the works in the aggregate,
possibly including the person doing the aggregation. And the author of
each of those works does have the right to limit your permission to
distribute in ways that might bar use in aggregations.
---
> It's also not clear that an aggregate work is in fact
> a single work for any legal purpose other than the aggregator's claim to
> copyright.
---

Not sure what you're trying to say there - what are we talking about
here other than the copyright?

---
> All you need to ship an aggregated work is the right to ship each
> of the individual works aggregated in it. For GPL'd works, you get that
> right from first sale, assuming you lawfully acquired the GPL'd work in the
> first place.
---

An aggregate work (the word used in the Copyright Act is either
"Compilation" or "Collective work", depending on the level of
creativity involved in forming it). In either case it is an
independent work. The person creating a Compilation has, at the least,
copyright in the organization of the material, plus copyright in any
original material she contributes. I agree, however, that all you need
to distribute tthe compilation is permission to distribute each of the
pieces in the given form (the author could have given you the right to
distribute only in conjunction with other specified works, for
instance) or placed other restrictions on the license.

First sale has nothing to do with this. First sale applies to the
redistribution or resale of copies you have purchased, not with the
right to make additional copies.

---
> ... For copyright law purposes, it is not a work because no creative
> input was needed to produce it beyond what was used to create the works from
> which it was formed.
---

Selection and organization are potentially creative. The Act
distinguishes between derivative works, compilations, and collective
works. A derivative work is a work "based on" the original work; a
compilation is a work formed by "collecting and assembling"
preexisting works "in such a way that the resulting work as a whole
constitutes an original work of authorship. A "collective work" is any
work formed by assembling independent works into a whole. All
compilations are collective works, but not all collective works are
compilations. Derivative works have nothing to do with aggregation.

---
> I recently bought two DVDs as a present for a friend of mine. I put the two
> DVDs in one box and shipped them to him. Just because the two DVDs are in
> one box does not make them a derivative work for copyright purposes because
> no creative input went in to them. I can even staple the two DVDs together
> if I want. I also don't need any special permission to ship the two of them
> together to my friend, first sale covers that. The right to ship each
> individual work is all that's needed to ship the aggregate.
---

First sale is separate from Copyright. You have the right to ship
them, but not to make copies of them. You can't for instance, ship
your friend a single DVD that combines the contents of the two you
bought. That's not unlike the distinction GPLv3 makes between
"propagating" and "conveying".

---
>
> Now, if I wanted to write my own story with elements from the content of
> both DVDs, that would be a derivative work because the combination itself is
> done in a creative way.
---

If it just rearranged the pieces, it would not be a derivative work,
it would be a compilation. If you transformed the pieces, it might be
a derivative work (depending on the nature of the transformation).

---
>
> No automated, mechanical process can create a derivative work of software.
> (With a few exceptions not relevant here.)
---

The truth of that statement depends on exactly what you mean by "an
automated, mechanical process". There are mechanical processs that
would simply produce the original work itself, not a derivative (e.g.,
changing the type from Courier to Times). There are other mechanical
proceses that would produce a collective work (e.g., inserting after
each line of the program a statement indicating whether or not it was
valid C). There are other mechanical processes that would create a
derivative work (e.g., a paraphrasing tool). It depends on the nature
of the mechanical process; that is, the decision, by you, to apply a
particular mechanical process is itself creative. But, perhaps that's
what you meant by your "few exceptions".

As always, IANAL,
scott

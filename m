Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWI3FLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWI3FLj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 01:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWI3FLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 01:11:39 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:51658 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750912AbWI3FLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 01:11:38 -0400
Subject: Re: GPLv3 Position Statement
From: James Bottomley <James.Bottomley@SteelEye.com>
To: tridge@samba.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <17692.54465.586487.473264@samba.org>
References: <1159498900.3880.31.camel@mulgrave.il.steeleye.com>
	 <17692.46192.432673.743783@samba.org>
	 <1159515086.3880.79.camel@mulgrave.il.steeleye.com>
	 <17692.54465.586487.473264@samba.org>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 16:28:46 -0400
Message-Id: <1159561726.9543.25.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-29 at 18:09 +1000, tridge@samba.org wrote:
>  > No, the point being made is that under v2, as long as the company was
>  > only distributing, it didn't have to go over its patent portfolio
>  > comparing it against the functions in the code on the website.
> 
> umm, you've got it entirely backwards! 
> 
> In GPLv2 you _do_ have to check your entire patent portfolio. You also
> have to check the patent portfolio of all of the companies you
> cross-license patents from. It says this:

No, you don't; that's the estoppel principle.  You only currently need
to scrutinise the pieces of open source your developers actually work
on.

>   For example, if a patent license would not permit royalty-free
>   redistribution of the Program by all those who receive copies
>   directly or indirectly through you, then the only way you could
>   satisfy both it and this License would be to refrain entirely from
>   distribution of the Program.
> 
> If your company is currently under the impression that distribution
> does not imply a patent license on the methods implemented in that
> code, then your lawyers are sailing very close to the wind. As you
> mention in the position statement, lawyers tend to take a broad
> interpretation when assessing their own companies liability, and it
> doesn't take a very broad interpretation of the GPLv2 to conclude that
> distribution implies a patent license.

This is the difference in how a lawyer thinks and how we think it might
be practically impossible to sue an open source project for infringement
(any open source project) because of the damage it would do to the
standing of the company, in theory, the option still exists from a legal
perspective.

> On the other hand, the current GPLv3 draft tries to ensure that the
> innocent don't get caught. It has the following:
> 
>   If you convey a covered work, knowingly relying on a
>   non-sublicensable patent license that is not generally available to
>   all, you must either (1) act to shield downstream users against the
>   possible patent infringement claims from which your license protects
>   you, or (2) ensure that anyone can copy the Corresponding Source of
>   the covered work, free of charge and under the terms of this
>   License, through a publicly available network server or other
>   readily accessible means.
> 
> The 'knowingly' part is very important, as is the 'or'. Compare this
> paragraph to the first draft of GPLv3. It has changed a lot. You know
> why it changed a lot? Because a whole lot of company lawyers saw that
> the draft 1 language was problematic. They gave feedback, and the FSF
> changed the draft to address their concerns.

Right ... it's trying to formulate the words to be the same as the
equitable estoppel principle in US law ... I just don't think it's quite
there yet.

> This is the bit I find so frustrating about this debate. The GPLv3
> current draft has had lots of input from precisely the people you say
> will be affected the most. There is a whole committee of lawyers from
> major corporations who are trying to ensure they will be happy with
> the result. The draft has improved as a result of this. The GPLv2 did
> not have that input, and as a result GPLv2 is more of a minefield
> regarding patents than the current GPLv3 draft.

And, in the discussion paper, the patents piece was phrased in terms of
the chilling effects on distributors.  Remove the chilling effect (i.e.
come up with a form of words all our distributors are happy with) and
that particular complaint evaporates.

> There is still more work to do, and the GPLv3 draft is not final, but
> if you think "its all OK, patents are not covered by GPLv2, I'll stick
> to that" then you are badly mistaken.
> 
>  > >  > HP is already on record as objecting to this as disproportionate.
>  > > 
>  > > Could you point me at their statement? I suspect it didn't use the
>  > > same words used in the position statement :-)
>  > 
>  > Actually, HP had no input at all into the statement we made, so I would
>  > be very surprised if the same words were used.
> 
> I'd also be very surprised if HP lawyers made a statement like the one
> in the position statement  :)

Please understand ... this discussion document was not made on behalf of
any lawyers or corporations.  It's a distillation of the points made in
the debate we had coming to the vote.  Each author represents themselves
only, not their company.  A lawyer was consulted before it was released,
but only to ensure that the discussion document couldn't damage any
legal actions (real or potential) that might be taken over the current
GPLv2.

James



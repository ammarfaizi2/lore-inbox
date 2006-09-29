Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWI2ILS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWI2ILS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWI2ILS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:11:18 -0400
Received: from dp.samba.org ([66.70.73.150]:49641 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S1751631AbWI2ILP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:11:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17692.54465.586487.473264@samba.org>
Date: Fri, 29 Sep 2006 18:09:37 +1000
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <1159515086.3880.79.camel@mulgrave.il.steeleye.com>
References: <1159498900.3880.31.camel@mulgrave.il.steeleye.com>
	<17692.46192.432673.743783@samba.org>
	<1159515086.3880.79.camel@mulgrave.il.steeleye.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

 > No, the point being made is that under v2, as long as the company was
 > only distributing, it didn't have to go over its patent portfolio
 > comparing it against the functions in the code on the website.

umm, you've got it entirely backwards! 

In GPLv2 you _do_ have to check your entire patent portfolio. You also
have to check the patent portfolio of all of the companies you
cross-license patents from. It says this:

  For example, if a patent license would not permit royalty-free
  redistribution of the Program by all those who receive copies
  directly or indirectly through you, then the only way you could
  satisfy both it and this License would be to refrain entirely from
  distribution of the Program.

If your company is currently under the impression that distribution
does not imply a patent license on the methods implemented in that
code, then your lawyers are sailing very close to the wind. As you
mention in the position statement, lawyers tend to take a broad
interpretation when assessing their own companies liability, and it
doesn't take a very broad interpretation of the GPLv2 to conclude that
distribution implies a patent license.

On the other hand, the current GPLv3 draft tries to ensure that the
innocent don't get caught. It has the following:

  If you convey a covered work, knowingly relying on a
  non-sublicensable patent license that is not generally available to
  all, you must either (1) act to shield downstream users against the
  possible patent infringement claims from which your license protects
  you, or (2) ensure that anyone can copy the Corresponding Source of
  the covered work, free of charge and under the terms of this
  License, through a publicly available network server or other
  readily accessible means.

The 'knowingly' part is very important, as is the 'or'. Compare this
paragraph to the first draft of GPLv3. It has changed a lot. You know
why it changed a lot? Because a whole lot of company lawyers saw that
the draft 1 language was problematic. They gave feedback, and the FSF
changed the draft to address their concerns.

This is the bit I find so frustrating about this debate. The GPLv3
current draft has had lots of input from precisely the people you say
will be affected the most. There is a whole committee of lawyers from
major corporations who are trying to ensure they will be happy with
the result. The draft has improved as a result of this. The GPLv2 did
not have that input, and as a result GPLv2 is more of a minefield
regarding patents than the current GPLv3 draft.

There is still more work to do, and the GPLv3 draft is not final, but
if you think "its all OK, patents are not covered by GPLv2, I'll stick
to that" then you are badly mistaken.

 > >  > HP is already on record as objecting to this as disproportionate.
 > > 
 > > Could you point me at their statement? I suspect it didn't use the
 > > same words used in the position statement :-)
 > 
 > Actually, HP had no input at all into the statement we made, so I would
 > be very surprised if the same words were used.

I'd also be very surprised if HP lawyers made a statement like the one
in the position statement  :)

Cheers, Tridge

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272484AbTGZNcg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 09:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272485AbTGZNcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 09:32:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:26578 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272484AbTGZNcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 09:32:35 -0400
Date: Sat, 26 Jul 2003 06:45:01 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: szepe@pinerecords.com, linux-kernel@vger.kernel.org
Subject: Re: some kernel config menu suggested tweaks
Message-Id: <20030726064501.3d04974d.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0307260821570.30928@localhost.localdomain>
References: <Pine.LNX.4.53.0307241256430.20528@localhost.localdomain>
	<20030726121432.GB6560@louise.pinerecords.com>
	<Pine.LNX.4.53.0307260821570.30928@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jul 2003 08:30:59 -0400 (EDT) "Robert P. J. Day" <rpjday@mindspring.com> wrote:

| On Sat, 26 Jul 2003, Tomas Szepe wrote:
| 
| > > [rpjday@mindspring.com]
| > > 
| > > 1) i mentioned this before, i think, but after one deselects
| > >    Power management, should ACPI Support and CPU Frequency
| > >    scaling still be available?
| > > 
| > >    the "make xconfig" menu display suggests a submenu 
| > >    structure there, which clearly isn't the case.
| > 
| > Why don't you go ahead and send a patch?

Ditto.  the right response.

| i'd be happy to, but based on my previous experience sending
| in a few patches, it's just not worth the aggravation any more.
| 
| just one of my patches that got adopted took, literally, several
| weeks of being dropped on the floor with no reason why.  and i
| had to resubmit it, slightly updated, for every BK rev of the
| kernel since the previous patch wouldn't apply cleanly --
| it might be a line or two off, which would require remaking
| the patch and resubmitting it *again*.  at which point, it
| would be dropped on the floor *again*.
| 
| don't get me wrong -- i understand that there has to be some
| form of QA in accepting kernel patches, and after a while, 
| regular submitters can build up a reputation.

and the QA is on patches, not (so much) on dialog.

| but, at this point, it's not terribly useful to encourage people
| to submit patches if those patches are just tossed.
| 
| it's like the classic catch-22:
| 
|   "we can't hire you.  you don't have enough experience doing
|     this job."
|   "ok, so how do i get experience?"
|   "well, you have to do this job for a while."
| 
| uh, right.  so, while there's not much point in my submitting
| patches, i can still toss suggestions from the sidelines, unless
| you have some ideas.  i'm certainly open to advice.

But suggestions from the sidelines are just too close to whinging
(Brit. spelling :) and moaning.  Not very helpful.

--
~Randy

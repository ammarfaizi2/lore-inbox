Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVA0Wqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVA0Wqi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 17:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVA0Wqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 17:46:38 -0500
Received: from zeus.kernel.org ([204.152.189.113]:901 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261259AbVA0WqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 17:46:16 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Zan Lynx <zlynx@acm.org>
Subject: Re: thoughts on kernel security issues
Date: Thu, 27 Jan 2005 16:18:25 -0600
X-Mailer: KMail [version 1.2]
Cc: Bill Davidsen <davidsen@tmr.com>, linux-os <linux-os@analogic.com>,
       John Richard Moser <nigelenki@comcast.net>, dtor_core@ameritech.net,
       Linus Torvalds <torvalds@osdl.org>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1050126143205.24013A-100000@gatekeeper.tmr.com> <05012710374600.20895@tabby> <1106846314.15927.6.camel@localhost>
In-Reply-To: <1106846314.15927.6.camel@localhost>
MIME-Version: 1.0
Message-Id: <05012716182500.22102@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 January 2005 11:18, Zan Lynx wrote:
> On Thu, 2005-01-27 at 10:37 -0600, Jesse Pollard wrote:
>
> >
> > > > Unfortunately, there will ALWAYS be a path, either direct, or
> > > > indirect between the secure net and the internet.
> > >
> > > Other than letting people use secure computers after they have seen the
> > > Internet, a good setup has no indirect paths.
> >
> > Ha. Hahaha...
> >
> > Reality bites.
>
> In the reality I'm familiar with, the defense contractor's secure
> projects building had one entrance, guarded by security guards who were
> not cheap $10/hr guys, with strict instructions.  No computers or
> computer media were allowed to leave the building except with written
> authorization of a corporate officer.  The building was shielded against
> Tempest attacks and verified by the NSA.  Any computer hardware or media
> brought into the building for the project was physically destroyed at
> the end.
>

And you are assuming that everybody follows the rules.

when a PHB, whether military or not (and not contractor) comes in and
says "... I don't care what it takes... get that data over there NOW..."
guess what - it gets done. Even if it is "less secure" in the process.

Oh - and about that "physically destroyed" - that used to be true.

Until it was pointed out to them that destruction of 300TB of data
media would cost them about 2 Million.

Suddenly, erasing became popular. And sufficient. Then it was reused
in a non-secure facility, operated by the same CO.

> Secure nets _are_ possible.

Yes they are. But they are NOT reliable.
Don't ever assume a "secure" network really is.

All it means is: "as secure as we can manage"

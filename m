Return-Path: <linux-kernel-owner+w=401wt.eu-S964826AbXABMGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbXABMGp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbXABMGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:06:44 -0500
Received: from ns.firmix.at ([62.141.48.66]:52393 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964808AbXABMGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:06:43 -0500
Subject: Re: Open letter to Linux kernel developers (was Re: Binary Drivers)
From: Bernd Petrovitsch <bernd@firmix.at>
To: Trent Waddington <trent.waddington@gmail.com>
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3d57814d0701020326o2b3b5636mcf31147ad00e82c6@mail.gmail.com>
References: <loom.20061215T220806-362@post.gmane.org>
	 <4587097D.5070501@opensound.com>
	 <13yc6wkb4m09f$.e9chic96695b.dlg@40tude.net>
	 <200612211816.kBLIGFdf024664@turing-police.cc.vt.edu>
	 <20061222115921.GT3073@harddisk-recovery.com>
	 <1167568899.3318.39.camel@gimli.at.home>
	 <3d57814d0612310503r282404afgd9b06ca57f44ab3c@mail.gmail.com>
	 <200701020404.l0244n3b024582@turing-police.cc.vt.edu>
	 <3d57814d0701012230v2e8b31eeqef7e542d73fc08d9@mail.gmail.com>
	 <1167730833.12526.35.camel@tara.firmix.at>
	 <3d57814d0701020326o2b3b5636mcf31147ad00e82c6@mail.gmail.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 02 Jan 2007 13:06:33 +0100
Message-Id: <1167739593.13369.27.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Firmix-Scanned-By: MIMEDefang 2.56 on ns.firmix.at
X-Spam-Score: -2.411 () AWL,BAYES_00,FORGED_RCVD_HELO
X-Firmix-Spam-Status: No, hits=-2.411 required=5
X-Firmix-Spam-Score: -2.411 () AWL,BAYES_00,FORGED_RCVD_HELO
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-02 at 21:26 +1000, Trent Waddington wrote:
> On 1/2/07, Bernd Petrovitsch <bernd@firmix.at> wrote:
> > While this is true (at last in theory), there is one difference in
> > practice: It is *much* easier to prove a/the patent violation if you
> > have (original?) source code than to reverse engineer the assembler dump
> > of the compiled code and prove the patent violation far enough to get to
> > a so-called "agreement" on the costs.
> 
> On 1/2/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> > You are forgetting the 11th commandment - thou shalt not get caught.
> > Most software patents (actually quite probably most patents) are held by
> > people who don't have the skills to go disassembling megabytes of code in
> > search of offenders.
> 
> The list of features which the driver supports is going to be
> sufficient evidence for 99% of patents that relate to computer
> graphics hardware.
>
> Regardless, in the *millions* of dollars that it costs to prosecute a
> patent violation case I think they can find a few grand to throw at a
> disassembler jockey.

Most of the cases (more or less "almost all" AFAIK) are handled/closed
without really going to court (since it is cheaper for all - especially
if the alleged patent violator is substantially smaller than the patent
holder and will not survive the law suit. See it as "protection money").
So there are no real statistics available on this issue.
I don't know about others but I wouldn't write an offer with a fixed
price for "look into assembler dumps, reverse engineer it and find an
infringement on a list of given patents" so the patent holder has to
list the patents and the amount of my time to invest (and then he will
get a price for it and no guarantees of success).
Thus the patent holder takes the whole risk that I don't find anything
useful (independent of the presence of a patent violation or my
inability to find/identify it).
And you need people wo are literate in "patent quak" and the technical
side so it will IMHP not work if you get someone not very expensive[0].

> So I'll take back what I said.. it does make some difference whether
> you release patent violating source code or patent violating binaries.
>  It makes about a 1% difference to the overall cost of prosecuting a
> patent lawsuit.

Given the above, the difference (measured in money/effort/....) is in
IMHO much larger than 1%.

> Now if you are done speculating why nvidia might have a reasonable
> reason for not releasing source code, can we just take it as read that
> the most likely reason is that they simply don't want to because they
> don't see the benefit?   If that's the case, what benefit can we offer
> them?

I don't know.
For network cards it helped to recommend hardware with open drivers. In
the graphic card department this didn't worked up to now.

	Bernd

[0]: That doesn't imply that hiring someone expensive guarantees
success.
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


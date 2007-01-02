Return-Path: <linux-kernel-owner+w=401wt.eu-S932831AbXABL0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932831AbXABL0Q (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932838AbXABL0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:26:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:20000 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932831AbXABL0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:26:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IHXMULAdNl03Y2Yf4KggCUlvPkuGW8L8/qmOTGu6JiUSXCbJuBdrF9UK0vv7rIIks5DlRto8zx09zkQagJQpVJfsvsC355/rA4CrssgBlK1KMXHhl28yf5BNo9kGU7FbKYK4HtDDHz+xSLvX9Rv8ENPHJbdjrw+phwR5ylWaOR8=
Message-ID: <3d57814d0701020326o2b3b5636mcf31147ad00e82c6@mail.gmail.com>
Date: Tue, 2 Jan 2007 21:26:14 +1000
From: "Trent Waddington" <trent.waddington@gmail.com>
To: "Bernd Petrovitsch" <bernd@firmix.at>
Subject: Re: Open letter to Linux kernel developers (was Re: Binary Drivers)
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       "Erik Mouw" <erik@harddisk-recovery.com>,
       "Giuseppe Bilotta" <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1167730833.12526.35.camel@tara.firmix.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/07, Bernd Petrovitsch <bernd@firmix.at> wrote:
> While this is true (at last in theory), there is one difference in
> practice: It is *much* easier to prove a/the patent violation if you
> have (original?) source code than to reverse engineer the assembler dump
> of the compiled code and prove the patent violation far enough to get to
> a so-called "agreement" on the costs.

On 1/2/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> You are forgetting the 11th commandment - thou shalt not get caught.
> Most software patents (actually quite probably most patents) are held by
> people who don't have the skills to go disassembling megabytes of code in
> search of offenders.

The list of features which the driver supports is going to be
sufficient evidence for 99% of patents that relate to computer
graphics hardware.

Regardless, in the *millions* of dollars that it costs to prosecute a
patent violation case I think they can find a few grand to throw at a
disassembler jockey.

So I'll take back what I said.. it does make some difference whether
you release patent violating source code or patent violating binaries.
 It makes about a 1% difference to the overall cost of prosecuting a
patent lawsuit.

Now if you are done speculating why nvidia might have a reasonable
reason for not releasing source code, can we just take it as read that
the most likely reason is that they simply don't want to because they
don't see the benefit?   If that's the case, what benefit can we offer
them?

Trent

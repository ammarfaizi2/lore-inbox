Return-Path: <linux-kernel-owner+w=401wt.eu-S1755277AbXABGaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277AbXABGaw (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 01:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755278AbXABGaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 01:30:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:33770 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277AbXABGav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 01:30:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TQU9AP1z8dNeUrhl8MCyJKn2dol3HhhjWci4NO3lDbWzsegmEGAw1MmSMmV9p2b9Akcq4Mwg7Yy/G/noTGIOPrWnTNXagsld4KHcnguSWUkg0JeYGnxd1WTbEvwJCDPDsK8mHVVqsc1HYOwapvH/JwvHgxgwWo9560Km+z7BKg8=
Message-ID: <3d57814d0701012230v2e8b31eeqef7e542d73fc08d9@mail.gmail.com>
Date: Tue, 2 Jan 2007 16:30:49 +1000
From: "Trent Waddington" <trent.waddington@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: Open letter to Linux kernel developers (was Re: Binary Drivers)
Cc: "Bernd Petrovitsch" <bernd@firmix.at>,
       "Erik Mouw" <erik@harddisk-recovery.com>,
       "Giuseppe Bilotta" <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200701020404.l0244n3b024582@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <loom.20061215T220806-362@post.gmane.org>
	 <200612162007.32110.marekw1977@yahoo.com.au>
	 <4587097D.5070501@opensound.com>
	 <13yc6wkb4m09f$.e9chic96695b.dlg@40tude.net>
	 <200612211816.kBLIGFdf024664@turing-police.cc.vt.edu>
	 <20061222115921.GT3073@harddisk-recovery.com>
	 <1167568899.3318.39.camel@gimli.at.home>
	 <3d57814d0612310503r282404afgd9b06ca57f44ab3c@mail.gmail.com>
	 <200701020404.l0244n3b024582@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/07, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> The binary blob in question is several megabytes in size.  Now, even
> totally *ignoring* who knowingly licensed/stole/whatever IP from who,
> that *still* leaves the problem of trying to write several megabytes of
> code that doesn't infringe on anybody's IP - particularly some of those
> vague submarine patents that should have been killed on "prior art" or
> "obviousness" grounds.
>
> So tell me - how *do* you release that much code without worrying about IP
> issues?

I'm going to try really hard to ignore how flammable your response
is.. I guess I deserve it.

I think you're repeating a myth that has become a common part of
hacker lore in recent years.  It's caused by how little we know about
software patents.  The myth is that if you release source code which
violates someone's patent that is somehow worse than if you release
binaries that violate someone's patent.  This is clearly, obviously,
false.  If you're practising the invention without a license in your
source code then you're practising the invention without a license in
binaries compiled from that source code.  Period.

Nvidia are not releasing source code to their drivers for one reason:
it's not their culture.  They don't see the need.  They don't see the
benefit.

Trent

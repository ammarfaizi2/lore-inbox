Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284326AbRLCIvn>; Mon, 3 Dec 2001 03:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284409AbRLCIuJ>; Mon, 3 Dec 2001 03:50:09 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:15119 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S284897AbRLCI2T>;
	Mon, 3 Dec 2001 03:28:19 -0500
Message-Id: <200112030244.fB32iMx4024126@sleipnir.valparaiso.cl>
To: Stanislav Meduna <stano@meduna.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue 
In-Reply-To: Your message of "Sun, 02 Dec 2001 09:01:32 BST."
             <200112020801.fB281Wt07893@meduna.org> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sun, 02 Dec 2001 23:44:22 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stanislav Meduna <stano@meduna.org> said:
> "Alan Cox" at dec 01, 2001 09:18:15 said:

[...]

> > If you want a high quality, tested supported kernel which has been through
> > extensive QA then use kernel for a reputable vendor, or do the QA work
> > yourself or with other people.

> Correct. But this has one problem - it is splitting resources.
> Pushing much of the QA work later in the process means
> that the bugs are found later, that there is more people
> doing this as absolutely necessary and that much more
> communication (and this can be the most important bottleneck)
> is needed as necessary.

Have you got any idea how QA is done in closed environments?

> The need of the VM change is probably a classical example -
> why was it not clear at the 2.4.0-pre1, that the current
> implementation is broken to the point of no repair?

Perhaps because of the same phenomenon that made MS state "WinNT 4.0 has no
flaws" when asked about a nasty problem shortly after release, and it is
now at sp6a + numerous "hotfixes". Like Win2k which now has sp2. Like
Solaris, which still is being fixed. Etc, ad nauseam. Complex software
*has* bugs, bugs which aren't apparent except under unsusual circumstances
are rarely found in the first round of bug chasing.

[...]

> As a user of the vendor's kernel I have no idea what to do
> with a bug.

Report it to the vendor, through the documented channels?
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616

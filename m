Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbUC3Rka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263768AbUC3Rka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:40:30 -0500
Received: from hades.almg.gov.br ([200.198.60.36]:471 "EHLO hades.almg.gov.br")
	by vger.kernel.org with ESMTP id S263460AbUC3RkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:40:16 -0500
Message-ID: <4069B200.8010309@almg.gov.br>
Date: Tue, 30 Mar 2004 14:44:32 -0300
From: Humberto Massa <humberto.massa@almg.gov.br>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: debian-devel@lists.debian.org
CC: debian-legal@lists.debian.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: POSSIVEL SPAM-- Re: Binary-only firmware covered by the GPL?
References: <YBtoCC.A.e-C.5maaAB@murphy>
In-Reply-To: <YBtoCC.A.e-C.5maaAB@murphy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

@ 30/03/2004 14:09 : wrote Henning Makholm :

> Scripsit Humberto Massa <humberto.massa@almg.gov.br>
> 
>>to modify the fw[], at least *legally* is MHO that any
>>recipient/redistributor of the file _can_ and _must_ consider the file
>>in *that* format as the preferred form for modification (pf4m) *and*,
>>considering it the source code, follow the directions of the GPL in
>>respect to modification and redistribution.
> 
> 
> No, law does not work that way. The phrase "preferred form for
> modification" has a clear enough, if somewhat fuzzy, literal meaning,
> and one cannot *implicitly* make it mean something that directly
> contrast to the literal meaning. If nobody *actually* prefers the
> binary blob for modification, then the binary blob is *not* the
> preferred form for modification. That's irrespective of whether the
> copyright holder behaves inconsistently.

Things could be different between jurisdictions, here the doctrine 
says about the interpretation of contracts, licenses, and law: we obey 
(1) what is written (2) what is implied by what is written (3) what is 
derived from what is written via case law (4) what is derived from 
what is written via the doctrine in law. In that order, and respecting 
legislative hierarchies.

There is another fail in your reasons here: as I said before, it just 
_happens_ to happen that fw[] = {} *is* the source code. What we must 
decide is what to do in the cases where *we don't know*.

After all, what happens is somebody *actually* prefers the binary blob 
for modification? And, what happens if _the copyright holder_ actually 
prefers the binary blob for modification? No inconsistency here.

> 
> 
>>* the /status quo/ obtained by observation of the previous item
>>prevails _until somebody proves_ that the fw[] = {} is *not* the
>>source code;
> 
> 
> And Debian's approach to software freedom doesn't work that way
> either. We treat software as non-free and non-distributable unless and
> until we see good and self-consistent evidence that it is actually
> free and distributable. The "burden of proof", to the extent that
> expression applies, is always on the side that claims that the
> software in question is OK for Debian to distribute.
> 

NOW you have a good argument. This mostly ends my line of reasoning. 
In debian: in dubio, non-free. This is not really nice, but it's OK. 
And I can live with that.

An addendum:
the DFSG does not define source code;
the GPL defines it as: "The source code for a work means the preferred 
form of the work for making modifications to it.";
the AFL goes further: "The term "Source Code" means the preferred form 
of the Original Work for making modifications to it and all available 
documentation describing how to modify the Original Work.";
maybe a good definition of source code is something we are needing? in 
the case of the AFL, not only { 0x0... } could be ruled out as source 
code, but even some-unknown-dsp-asm-without-comments, too.

-- 
br,M

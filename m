Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135209AbRDVEMJ>; Sun, 22 Apr 2001 00:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135210AbRDVEL6>; Sun, 22 Apr 2001 00:11:58 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:29956 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135208AbRDVELk>;
	Sun, 22 Apr 2001 00:11:40 -0400
Date: Sun, 22 Apr 2001 00:12:09 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system
Message-ID: <20010422001209.G15644@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <esr@thyrsus.com> <200104220228.f3M2St1s023522@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104220228.f3M2St1s023522@sleipnir.valparaiso.cl>; from vonbrand@sleipnir.valparaiso.cl on Sat, Apr 21, 2001 at 10:28:55PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@sleipnir.valparaiso.cl>:
> It has been my observation that human organizations over time grow
> mechanisms for doing the routine (i.e., frequent) tasks quite efficiently,
> while sporadic tasks are usually handled in ad hoc, case by case ways,
> which can be very inefficient (and usually frustrating to the would-be
> user).

Right you are.
 
> In our case, the whole kernel development system is quite adept at soaking
> up point patches (the bread-and-butter in LKM), while larger scope changes
> (like the one you are proposing, and also some cleanup patch I proposed a
> long while back, and the other scattered changes I've seen fly by) are very
> infrequent and so not handled at all well.

Indeed this is the case.  I think such global cleanups are, in fact, less
frequent than they should be precisely *because* lkml's social machinery
discourages them.

> Question is, is it really worth it to create specialized tools for this
> very rare case?

Yes, if the rare case of supporting global cleanups actually needs to be a
more common one.  Think about that for a while, please.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Faith may be defined briefly as an illogical belief in the occurrence
of the improbable...A man full of faith is simply one who has lost (or
never had) the capacity for clear and realistic thought. He is not a
mere ass: he is actually ill.
	-- H. L. Mencken 

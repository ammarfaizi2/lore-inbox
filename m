Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287950AbSABUWe>; Wed, 2 Jan 2002 15:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287949AbSABUWZ>; Wed, 2 Jan 2002 15:22:25 -0500
Received: from svr3.applink.net ([206.50.88.3]:7687 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287944AbSABUWL>;
	Wed, 2 Jan 2002 15:22:11 -0500
Message-Id: <200201022021.g02KL8Sr021924@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Jonathan Amery <jdamery@chiark.greenend.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
Date: Wed, 2 Jan 2002 14:17:25 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011220203223.GO7414@vega.digitel2002.hu> <20011220164948.M23621@mail.cafes.net> <E16Lp0s-0003aS-00@chiark.greenend.org.uk>
In-Reply-To: <E16Lp0s-0003aS-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 January 2002 11:17, Jonathan Amery wrote:
> In article <3C2315D6.40105@purplet.demon.co.uk> you write:
> >Engineers not (yet) being familiar with the relatively new SI (and IEEE)
> >binary prefixes is just about acceptable. "Engineers" that misuse k/K
> >and (worse!) m/M should be in a different field entirely. The SI system
> >is generally taught as basic science to pre-teenagers. There is no
> >excuse!
>
>  How many of them learn it though?
>
>  Jonathan (occasionally guilty of s/kB/KB/ himself).
>

For the 10th time, the K v. k issue is due to the standards
body ignoring common sense and following tradition instead.
All positive powers of ten should have upper-case letters
	(D,H,K,M,T,P)
and negative powers of ten should use lower-case letters.
	(d,c,m,n,p)

The KB meaning 2^10 B instead of 10^3 B is just plain dumb,
and that's why the standards body tried to fix it with KiB.
But again, this solution was considered to look and sound
goofy and to be based on stupid mathematical games;
hence this whole long thread.   <rant>A thread which has shown
to me that most comp. sci. folks lack common sense and
are pendantic to the max.</rant>


-- 
timothy.covell@ashavan.org.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbUKRCPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbUKRCPS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 21:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUKRCNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 21:13:34 -0500
Received: from smtpout.mac.com ([17.250.248.88]:29928 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262393AbUKRCMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 21:12:12 -0500
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEOHPNAA.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKEEOHPNAA.davids@webmaster.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3D5D0803-3907-11D9-85DC-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: clemens@endorphin.org, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: GPL version, "at your option"?
Date: Wed, 17 Nov 2004 21:12:04 -0500
To: davids@webmaster.com
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 17, 2004, at 20:04, David Schwartz wrote:
> 	Your logic is totally flawed. Successor versions can certainly add
> limitations.

Your logic is equally flawed.

> 	Consider the following hypothetical, GPL version 3 allows you to 
> relicense
> the code under the FreeBSD license. Someone relicenses Linux (with 
> lots of
> later modification) under the FreeBSD license. Now people who receive 
> the
> binaries from this new stream of Linux are not entitled to the source 
> code.
s/relicense/distribute/g;  You can't relicense code without owning the 
original
copyright.  You _can_ however, receive a license to distribute.

If I receive a binary from them, I receive the original "dual" license. 
This means
that anyone who receives it may license it using GPL version "2" or, at 
their
option, any later version.  This means that when I get some binaries 
from some
random company that used your mythical version 3 to distribute under the
terms of any BSD license, I _also_ receive a license to the same code 
under
the terms of GPL v2 (at my option :-D).  This means that since my 
license from
company X is GPL v2 (at my option), I must receive sources under GPL 
v2. In
practice this means that you _can't_ change much of what the GPL says in
future versions, at least as far as I can see, without causing said 
future version
to be legally invalid.

> 	Suppose GPL version 3 has no requirement that you make the source
> available. I can then ship Linux without making any source available 
> at all
> by claiming that I'm using that later version at my option.

And I can equally legally demand the sources under GPL version 2, at my
option, and you will be forced to give them to me, not at your option 
:-D.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------



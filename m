Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267588AbUIJDEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267588AbUIJDEZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 23:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267591AbUIJDEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 23:04:24 -0400
Received: from lakermmtao01.cox.net ([68.230.240.38]:15538 "EHLO
	lakermmtao01.cox.net") by vger.kernel.org with ESMTP
	id S267588AbUIJDEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 23:04:13 -0400
In-Reply-To: <1094784025.19981.188.camel@hole.melbourne.sgi.com>
References: <20040908123524.GZ390@unthought.net> <322909db040908080456c9f291@mail.gmail.com> <20040908154434.GE390@unthought.net> <1094661418.19981.36.camel@hole.melbourne.sgi.com> <20040909140017.GP390@unthought.net> <1094784025.19981.188.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <16F6CCFE-02D6-11D9-B8B0-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Jakob Oestergaard <jakob@unthought.net>,
       Anando Bhattacharya <a3217055@gmail.com>, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Major XFS problems...
Date: Thu, 9 Sep 2004 23:04:11 -0400
To: Greg Banks <gnb@melbourne.sgi.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 09, 2004, at 22:40, Greg Banks wrote:
> Like I said, knfsd does unnatural things to the dcache.

Perhaps there needs to be a standard API that knfsd can use to do many
of the (currently) non-standard dcache operations.  This would likely be
useful for other kernel-level file-servers that would be useful to have
(OpenAFS? Coda?).  Of course, I could just be totally ignorant of some
nasty reason for the unstandardized hackery, but it doesn't hurt to
ask. :-D

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------



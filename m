Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbULNFBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbULNFBp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 00:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbULNFBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 00:01:45 -0500
Received: from lakermmtao06.cox.net ([68.230.240.33]:31645 "EHLO
	lakermmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261417AbULNFBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 00:01:35 -0500
In-Reply-To: <20041214040125.70151.qmail@web90010.mail.scd.yahoo.com>
References: <20041214040125.70151.qmail@web90010.mail.scd.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3A1635D6-4D8D-11D9-B94B-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Linux - open design??
Date: Tue, 14 Dec 2004 00:01:34 -0500
To: ram mohan <madhaviram123@yahoo.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 13, 2004, at 23:01, ram mohan wrote:
> Hi All,
> When we say Linux is open source and we have the sites
> where we can download the source from, why is not
> linux design (High Level and Low Level) not that well
> publicised? (Or is it that I am not aware of - in
> which case I would like to know where it is.)
> I am looking for a traceability matrix- where I start
> with requirements of Linux, dig into the
> design(HLD/LLD) and then the source.

Well, generally the linux architecture changes so fast that any such 
documents
become nearly immediately out of date and useless.  There is some 
really good
_current_ stuff in the Documentation directory of whatever kernel 
sources you've
got, if you want to take a look, but that's about it.  There are a 
number of sites that
document some of the simpler API's, but the complex stuff just changes 
too much
for that kind of thing to be useful.  Oh, and BTW, concerning a 
traceability matrix,
generally it doesn't really exist except for proprietary software.  
Linux design is
not "requirements-based" as commercial software is, it's 
"I-want-this-feature-bad-
-enough-to-code-it-and-get-it-included-based".  I suspect that 
companies like
IBM internally have requirements-based systems to organize their 
employees
into various tasks, but publicly there is no such system, aside from 
"It's broken
and I fixed it with this patch:".

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVCPAVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVCPAVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVCPAVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:21:51 -0500
Received: from smtpout.mac.com ([17.250.248.89]:5861 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262182AbVCPAVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 19:21:42 -0500
In-Reply-To: <42375119.3000506@lsrfire.ath.cx>
References: <1110771251.1967.84.camel@cube> <42355C78.1020307@lsrfire.ath.cx> <1110816803.1949.177.camel@cube> <Pine.LNX.4.58.0503142333480.6357@be1.lrz> <1110854667.7893.203.camel@cube> <42375119.3000506@lsrfire.ath.cx>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <be44570eada10800cf41d7317f4f2739@mac.com>
Content-Transfer-Encoding: 7bit
Cc: pj@engr.sgi.com, Bodo Eggert <7eggert@gmx.de>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH][RFC] Make /proc/<pid> chmod'able
Date: Tue, 15 Mar 2005 19:21:20 -0500
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 15, 2005, at 16:18, Rene Scharfe wrote:
> It's easily visible in the style of public toilets: in some contries 
> you have one big room with no walls in between where all men or women 
> merrily shit together, in other countries (like mine) every person can 
> lock himself into a private closet.  Both ways work, there's nothing 
> too special about using a toilet, but I'm simply used to the privacy 
> provided by those thin walls.  I assure you, I don't do anything evil 
> in there. :]

Just as long as our labs "bathrooms" don't mysteriously get a
bazillion walls all over the place on kernel upgrade, we're ok.
I don't mind adding new options for advanced security, as long
as you don't change the defaults.  It's hard enough managing
a boatload of workstations under ideal conditions.  When the
default settings change every month it gets really annoying
really quickly. :-D.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------



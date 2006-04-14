Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWDNRuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWDNRuW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 13:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWDNRuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 13:50:21 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:16855 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S1751335AbWDNRuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 13:50:21 -0400
Date: Fri, 14 Apr 2006 19:50:18 +0200
From: David Weinehall <tao@acc.umu.se>
To: David Schwartz <davids@webmaster.com>
Cc: Ramakanth Gunuganti <rgunugan@yahoo.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL issues
Message-ID: <20060414175018.GD23222@vasa.acc.umu.se>
Mail-Followup-To: David Schwartz <davids@webmaster.com>,
	Ramakanth Gunuganti <rgunugan@yahoo.com>,
	Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0604112055380.25940@yvahk01.tjqt.qr> <MDEHLPKNGKAHNMBLJOLKAEFLLFAB.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEFLLFAB.davids@webmaster.com>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 04:39:59AM -0700, David Schwartz wrote:
> 
> > One thing that is clear in the GPL: If you link the kernel with something
> > else to an executable, the resulting blob (and therefore the
> > sources to the
> > proprietary part) must be GPL.
> 
> 	Actually, that is *far* from clear.
> 
> 	First, the GPL cannot set its own scope. The GPL could say that
> 	if you stored a program in the same room as a GPL program, the
> 	program must be GPL.  So *nothing* the GPL says will answer this
> 	question -- the question is, can the GPL attach by linking?
> 
> 	The contrary argument would be that linking two programs
> 	together is an automated process. There is no creative input in
> 	the linking process. So it does not legally produce a single
> 	work, but a mechanical combination of the two original works.
> 
> 	The proof that the executable is not a work for copyright
> 	purposes is this simple -- could a person who took two object
> 	files out of the box and linked them together claim copyright in
> 	the new derivative work he just produced? I think the answer
> 	would be obvious -- the executable is not a new work, it's just
> 	the two original works combined.

[snip]

Ahhh, but you're missing the whole point of the GPL.  The GPL is
not really a normal license, it's a copyright license.  Basically,
copyright law doesn't allow you to do *anything* with someone elses
work without permission.  The GPL grants you such rights.
However, in exchange for this, you agree to follow the license when
redistributing your software that you built against the GPL:ed
software.

So, in essence, *if* you choose to redistribute your work, you must
abide by the GPL.  And the GPL tells you to GPL your work too, if it
falls within the scope that the GPL defines.  It thus have nothing
to do with whether the programs are a mechanical combination of
two original works or not.  The only point where this comes in is
where the GPL defines its scope.

Thus, if the GPL said that all programs distributed on the same CD
as a GPL:ed program needs to be licensed under the GPL, and you
redistribute your software on that CD, you must license your software
under the GPL, unless you want to be in violation with the license.

Again, I'm not a lawyer...


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/

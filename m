Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316821AbSGLTti>; Fri, 12 Jul 2002 15:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSGLTti>; Fri, 12 Jul 2002 15:49:38 -0400
Received: from pD9E235D3.dip.t-dialin.net ([217.226.53.211]:16518 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316821AbSGLTtf>; Fri, 12 Jul 2002 15:49:35 -0400
Date: Fri, 12 Jul 2002 13:52:06 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207121937.g6CJb1aq018419@burner.fokus.gmd.de>
Message-ID: <Pine.LNX.4.44.0207121345180.3421-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 12 Jul 2002, Joerg Schilling wrote:
> The result of such bad hacks is that nobody really tests whether the new
> code works.

I want you to prove the three things your statement says:

 - that this code is only implementable via a bad hack, and your idea is 
   implementable via a better hack
 - Andre's Code is - without a look at it - ugly
 - Unification changesets stay untested

> Depending on the kernel version, this either causes a system panic or
> just does not work at all. As all ATAPI CD-writers and CD-rom drives
> have a fallback to ATA commands, nobody who does not like to use a
> writer will ever notice the problem. They simply access the CD-ROM as
> read only ATA disk. If ide-cd would have been banned this bug would have
> been fixed years ago.

Because we can't tell Linux users "your (once favorite) CD-ROM is not 
implemented in Linux (any more), and will never ever be". If we explicitly 
exclude hardware, where do we end?!

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------


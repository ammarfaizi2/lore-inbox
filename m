Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282418AbRL0VVU>; Thu, 27 Dec 2001 16:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282373AbRL0VVL>; Thu, 27 Dec 2001 16:21:11 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33174 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S282276AbRL0VU6>;
	Thu, 27 Dec 2001 16:20:58 -0500
Date: Thu, 27 Dec 2001 16:20:57 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: Dave Jones <davej@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011227162057.C23942@havoc.gtf.org>
In-Reply-To: <a0fntk$ukm$1@penguin.transmeta.com> <Pine.LNX.4.33.0112271928260.15706-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112271928260.15706-100000@Appserv.suse.de>; from davej@suse.de on Thu, Dec 27, 2001 at 07:37:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 07:37:16PM +0100, Dave Jones wrote:
> On Thu, 27 Dec 2001, Linus Torvalds wrote:
> > We've seen this several times in Linux - David, for example, used to
> > maintain his CVS tree, and he ended up being rather frustrated about
> > having to then maintain it all and clean up the bad parts because I
> > didn't want to apply them (and he didn't really want me to) and he
> > couldn't make people clean up themselves because "once it was in, it was
> > in".
> 
> "Used to" ? cvs @ vger.samba.org was still being maintained before
> I went on xmas vacation. Did I miss something ?

Kinda-sorta...

vger cvs is maintained by DaveM and current, but one catches holy hell
from Dave if the non-DaveM patches in vger are not merged into the
Linus/Marcelo trees rapidly ;-)  So in that way vger cvs is not really a
branch but a staging area for the official tree.

	Jeff



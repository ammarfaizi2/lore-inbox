Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293306AbSCRXna>; Mon, 18 Mar 2002 18:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293314AbSCRXnV>; Mon, 18 Mar 2002 18:43:21 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48395 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293306AbSCRXnO>; Mon, 18 Mar 2002 18:43:14 -0500
Date: Tue, 19 Mar 2002 00:43:15 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper licence issues
Message-ID: <20020318234315.GJ1740@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020318212617.GA498@elf.ucw.cz> <20020318144255.Y10086@work.bitmover.com> <20020318231427.GF1740@atrey.karlin.mff.cuni.cz> <20020319002241.K17410@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > > Pavel, the problem here is your fundamental distrust.  
>  > By giving me binary-only installer you ask me to trust you. You ask me
>  > to trust you without good reason [it only generates .tar.gz and
>  > shellscript, why should it be binary? Was not shar designed to handle
>  > that?], and that's pretty suspect.
> 
>  Bitmover doing anything remotely suspect in an executable installer
>  would be commercial suicide, do you distrust realplayer too?

I've seen windows installers doing *very* suspect stuff.

I distrust realplayer, too, but I think those people are bad enough
that there's no point complaining. I believed Larry could see that
binary installers are evil.

>  did you distrust early netscape before they released source?

Yep.

>  yada yada countless other programs..

Actually, I only ever did binary installation of realplayer, as far as
I can remember. And that was at time national television died, and I
wanted to know what's going on.

>  If your distrust of commercial organisations providing binaries
>  is so great, you know where objdump, strace and friends are.

strace does not solve the problem (it is trivial to detect you are
traced), and I do not think Larry should require me to objdump
installer.

[You see, binary-only installers are total nightmare from security
perspective. They are widespread on windoze, and it *is* problem
there. I do not want them on linux.]

							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.

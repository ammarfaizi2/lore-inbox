Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293092AbSCSWfX>; Tue, 19 Mar 2002 17:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293129AbSCSWfP>; Tue, 19 Mar 2002 17:35:15 -0500
Received: from [195.39.17.254] ([195.39.17.254]:4483 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S293092AbSCSWfC>;
	Tue, 19 Mar 2002 17:35:02 -0500
Date: Tue, 19 Mar 2002 23:06:32 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper licence issues
Message-ID: <20020319220631.GA1758@elf.ucw.cz>
In-Reply-To: <20020318212617.GA498@elf.ucw.cz> <20020318144255.Y10086@work.bitmover.com> <20020318231427.GF1740@atrey.karlin.mff.cuni.cz> <20020319002241.K17410@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
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

Actually, the installer contains security hole allowing any user to
overwrite any file on system if you install it as root with simple
symlink. [Its easy to fix, and I hope they fix it in next version.]

Do you see why I hate binary installers, now?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

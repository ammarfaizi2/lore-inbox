Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSDGWZ5>; Sun, 7 Apr 2002 18:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSDGWZ4>; Sun, 7 Apr 2002 18:25:56 -0400
Received: from [195.39.17.254] ([195.39.17.254]:12682 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313419AbSDGWZ4>;
	Sun, 7 Apr 2002 18:25:56 -0400
Date: Sun, 7 Apr 2002 16:30:27 +0000
From: Pavel Machek <pavel@suse.cz>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre6
Message-ID: <20020407163026.G46@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0204050159130.10818-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> <viro@math.psu.edu> (02/04/01 1.322)
> 	turns (mount_sem,vfsmntlist,root_vfsmnt) into per-process object
> 
> <viro@math.psu.edu> (02/04/01 1.323)
> 	makes /proc/mounts a symlink to /proc/<pid>/mounts.

I don't see how this could be considered bugfix. Seems like new feature to
me, and dangerous one, too.
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


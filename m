Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135543AbRDSENC>; Thu, 19 Apr 2001 00:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135545AbRDSEMw>; Thu, 19 Apr 2001 00:12:52 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:34322 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S135543AbRDSEMt>;
	Thu, 19 Apr 2001 00:12:49 -0400
Date: Thu, 19 Apr 2001 01:11:07 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Richard Gooch <rgooch@atnf.csiro.au>
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Cross-referencing frenzy
In-Reply-To: <200104190400.f3J40Dm00992@mobilix.atnf.CSIRO.AU>
Message-ID: <Pine.LNX.4.21.0104190109480.1685-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2001, Richard Gooch wrote:

> > CONFIG_APM_IGNORE_SUSPEND_BOUNCE: arch/i386/kernel/apm.c
> > CONFIG_DEVFS_TTY_COMPAT: Documentation/filesystems/devfs/ChangeLog
> > CONFIG_DEVFS_BOOT_OPTIONS: Documentation/filesystems/devfs/ChangeLog
> > CONFIG_DEVFS_DISABLE_OLD_NAMES: Documentation/filesystems/devfs/ChangeLog
> > CONFIG_DEVFS_DISABLE_OLD_TTY_NAMES: Documentation/filesystems/devfs/ChangeLog
> > CONFIG_DEVFS_ONLY: Documentation/filesystems/devfs/ChangeLog
> > CONFIG_DEVFS: Documentation/filesystems/devfs/ChangeLog
> 
> These are options that used to be used,
    ....
> These should not be removed

This makes no sense at all.  Do you have any particular
reason for keeping this deadwood around ?

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


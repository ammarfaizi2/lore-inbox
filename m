Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267758AbTAXPlI>; Fri, 24 Jan 2003 10:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267761AbTAXPlI>; Fri, 24 Jan 2003 10:41:08 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8452 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267758AbTAXPlH>;
	Fri, 24 Jan 2003 10:41:07 -0500
Date: Fri, 24 Jan 2003 16:46:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kevin Lawton <kevinlawton2001@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider)
Message-ID: <20030124154647.GA20371@elf.ucw.cz>
References: <20030122182341.66324.qmail@web80309.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030122182341.66324.qmail@web80309.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm working on running Linux as a guest OS inside a
> lightweight cut-down plex86 environment.  My goal is to
> run a stock Linux kernel, which can be slimmed down to
> the essentials via kernel configuration, since a guest
> OS doesn't need to drive much hardware.

Can you explain a bit more about plex86? I thought plex86 aims to be
complete machine emulation, capable of running winNT (for example). I
don't think M$ will accept such a patch from you...

Or will it only increase performance when running under plex86?

								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?

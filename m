Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267752AbTAXPn3>; Fri, 24 Jan 2003 10:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267761AbTAXPn2>; Fri, 24 Jan 2003 10:43:28 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8964 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267752AbTAXPn2>;
	Fri, 24 Jan 2003 10:43:28 -0500
Date: Fri, 24 Jan 2003 16:49:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kevin Lawton <kevinlawton2001@yahoo.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider)
Message-ID: <20030124154935.GB20371@elf.ucw.cz>
References: <p7365sh0zcw.fsf@oldwotan.suse.de> <20030123051119.18154.qmail@web80304.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123051119.18154.qmail@web80304.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> OK, here's my re-submit of patches, after some great
> clean-up/simplification ideas from Andrew Morton and Andi Kleen.

Please try to inline the patches, it makes it easier to comment.

How is plex86-aware-linux running under plex86 different from user
mode linux? Do you think you can make it faster?
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?

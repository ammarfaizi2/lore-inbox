Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbTBEThp>; Wed, 5 Feb 2003 14:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264748AbTBETho>; Wed, 5 Feb 2003 14:37:44 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:38414 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264745AbTBEThU>;
	Wed, 5 Feb 2003 14:37:20 -0500
Date: Wed, 5 Feb 2003 20:46:55 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030205194655.GA3434@mars.ravnborg.org>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>, lm@bitmover.com,
	linux-kernel@vger.kernel.org
References: <20030205174021.GE19678@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205174021.GE19678@dualathlon.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea

It was in cset 1.879.43.1 that the change was made.
Long time before the cset you noted.

To me it looks like the same change were applied twice to Linus's
BK tree.


[cset's from a vanilla clone of Linus'es BK tree].

	Sam

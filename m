Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267949AbTBMBjW>; Wed, 12 Feb 2003 20:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267950AbTBMBjW>; Wed, 12 Feb 2003 20:39:22 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:20864 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S267949AbTBMBjV>; Wed, 12 Feb 2003 20:39:21 -0500
Date: Thu, 13 Feb 2003 01:50:20 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Larry McVoy <lm@work.bitmover.com>, Pavel Machek <pavel@suse.cz>,
       Andrea Arcangeli <andrea@suse.de>, lm@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030213015020.GA13886@bjl1.jlokier.co.uk>
References: <20030205174021.GE19678@dualathlon.random> <20030207145651.GA345@elf.ucw.cz> <20030208182820.GA14035@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030208182820.GA14035@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> 1) We're going to make a CVS archive of Linus tree available, automatically
>    updated, and we'll rsync it to some public place like kernel.org so you
>    can get at the data in a way you want with no BK involved at all.

Why not rsync the SCCS tree and let others worry about format
conversions?  Presumably that would be much less work.  (I'm
presuming, I know).

-- Jamie

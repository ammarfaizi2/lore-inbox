Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267608AbTBMBq6>; Wed, 12 Feb 2003 20:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267609AbTBMBq6>; Wed, 12 Feb 2003 20:46:58 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:22400 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S267608AbTBMBq4>; Wed, 12 Feb 2003 20:46:56 -0500
Date: Thu, 13 Feb 2003 01:57:58 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Larry McVoy <lm@work.bitmover.com>, Pavel Machek <pavel@suse.cz>,
       Andrea Arcangeli <andrea@suse.de>, lm@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030213015758.GA13897@bjl1.jlokier.co.uk>
References: <20030205174021.GE19678@dualathlon.random> <20030207145651.GA345@elf.ucw.cz> <20030208182820.GA14035@work.bitmover.com> <20030213015020.GA13886@bjl1.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030213015020.GA13886@bjl1.jlokier.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> Why not rsync the SCCS tree and let others worry about format
> conversions?  Presumably that would be much less work.  (I'm
> presuming, I know).

Sorry if the tone of that seemed a bit harsh.

I mean that it might be less work for Larry to just mirror the SCCS tree
which Bitkeeper itself maintains - less overhead for Bitmover.

Just a suggestion.

cheers,
-- Jamie

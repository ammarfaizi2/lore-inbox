Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbTBEThO>; Wed, 5 Feb 2003 14:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbTBEThO>; Wed, 5 Feb 2003 14:37:14 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:29609 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264730AbTBEThM>;
	Wed, 5 Feb 2003 14:37:12 -0500
Date: Wed, 5 Feb 2003 19:42:57 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, lm@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030205194257.GA17922@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	lm@bitmover.com, linux-kernel@vger.kernel.org
References: <20030205174021.GE19678@dualathlon.random> <20030205102308.68899bc3.akpm@digeo.com> <20030205184535.GG19678@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205184535.GG19678@dualathlon.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 07:45:35PM +0100, Andrea Arcangeli wrote:

 > I can't yet fetch a full tree out of bitkepper yet (you know the network
 > protocol must be reverse engeneered first), I can only fetch
 > incrementals with metadata and raw patch so far because this is the
 > thing I care about most, after I've all the changesets in live form in
 > my db I don't mind too much about the ability to checkout a the whole
 > tree too, since I can do the same starting from my open db rather than
 > using the proprietary one.

Why not save effort, and just grab from http://ftp.kernel.org/pub/linux/kernel/v2.5/testing/cset/

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

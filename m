Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267784AbTBJLTW>; Mon, 10 Feb 2003 06:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267725AbTBJLTW>; Mon, 10 Feb 2003 06:19:22 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:22686 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S267755AbTBJLTT>;
	Mon, 10 Feb 2003 06:19:19 -0500
Date: Mon, 10 Feb 2003 12:28:40 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       "Theodore Ts'o" <tytso@mit.edu>, tbm@a2000.nu
Subject: Re: fsck out of memory
In-Reply-To: <15942.46375.478902.665549@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.53.0302101226530.7274@ddx.a2000.nu>
References: <Pine.LNX.4.53.0302071555110.718@ddx.a2000.nu>
 <Pine.LNX.4.53.0302071800200.1306@ddx.a2000.nu> <20030207102858.P18636@schatzie.adilger.int>
 <Pine.LNX.4.53.0302090953440.1039@ddx.a2000.nu>
 <15942.46375.478902.665549@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2003, Peter Chubb wrote:

> Is there any reason why you're sticking with the 2.4 kernel and ext3?
> XFS has been used (on SGI systems) for much longer with large disk
> arrays, and I'd expect (linux-specific bugs aside) it to be a more
> mature product for this application.

i used ext2/3 on all my servers
never checked out xfs or reiserfs, so don't really want to check it out an
an important server, but if it's better to switch to something else..... ?

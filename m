Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267292AbTBQOnF>; Mon, 17 Feb 2003 09:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbTBQOl7>; Mon, 17 Feb 2003 09:41:59 -0500
Received: from 5-077.ctame701-1.telepar.net.br ([200.193.163.77]:29879 "EHLO
	5-077.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267263AbTBQOkk>; Mon, 17 Feb 2003 09:40:40 -0500
Date: Mon, 17 Feb 2003 11:50:02 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: Jamie Lokier <jamie@shareable.org>
cc: Nicolas Pitre <nico@cam.org>, David Lang <david.lang@digitalinsight.com>,
       Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: openbkweb-0.0
In-Reply-To: <20030217043108.GA16137@bjl1.jlokier.co.uk>
Message-ID: <Pine.LNX.4.50L.0302171120060.16271-100000@imladris.surriel.com>
References: <Pine.LNX.4.44.0302152104500.6594-100000@dlang.diginsite.com>
 <Pine.LNX.4.44.0302160027390.17241-100000@xanadu.home>
 <20030217043108.GA16137@bjl1.jlokier.co.uk>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, Jamie Lokier wrote:

> However, rsync from the repository is generally _much_ faster than CVS
> if you are tracking changes, so I (an impatient modem user) prefer rsync.

> So I vote for rsync read-only access to the actual SCCS-ish repository
> files that BK manages.

See ftp://nl.linux.org/pub/linux/bk2patch/

You can get BK trees (uncompressed SCCS) via rsync, as well as
patches from the latest tagged version to the head of the tree.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

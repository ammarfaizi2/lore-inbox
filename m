Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137190AbREKRvP>; Fri, 11 May 2001 13:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137194AbREKRvG>; Fri, 11 May 2001 13:51:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1292 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S137191AbREKRu7>; Fri, 11 May 2001 13:50:59 -0400
Subject: Re: reiserfs, xfs, ext2, ext3
To: reiser@namesys.com (Hans Reiser)
Date: Fri, 11 May 2001 18:47:21 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hps@intermeta.de,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
In-Reply-To: <3AFBBD16.7AC1019C@namesys.com> from "Hans Reiser" at May 11, 2001 03:21:10 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yH0c-0001Q8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you referring to Neil Brown's nfs operations patch as being as ugly as
> hell, or something else?  Just want to understand what you are saying before
> arguing.....

Andi has sent me some stuff to look at. He listed four implementations and I've
only seen two of them

> NFS is ugly as hell, and we just try to conform to whatever is the latest trend
> expected to be accepted since I really don't care so long as it works and
> doesn't uglify ReiserFS more than necessary.  If you have another approach, one
> that is less ugly, please let us know.  This is the first I have heard someone

Oh believe me we agree in great detail where the -problem- is. Unfortunately
the spec is kind of stuck.  Its finding a minimally invasive solution for 2.4
pending fixing it properly in 2.5


Alan


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316749AbSERF5b>; Sat, 18 May 2002 01:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316754AbSERF5a>; Sat, 18 May 2002 01:57:30 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:43415 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316749AbSERF53>; Sat, 18 May 2002 01:57:29 -0400
Date: Sat, 18 May 2002 00:57:08 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Andreas Dilger <adilger@clusterfs.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Htree directory index for Ext2, updated
In-Reply-To: <E178x1B-0000DW-00@starship>
Message-ID: <Pine.LNX.4.44.0205180052120.26841-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2002, Daniel Phillips wrote:

>   - Somebody decided to add another level on top of the linux root directory
>     in their source directory.  I can't import patches into that.
> 
>   - I can apply patches to bitkeeper repository using the normal 'patch',
>     but Bitkeeper gets its revenge later, as each bk edit command starts
>     off by throwing away the patch.

Hmmh, that's always worked for me. Actually I always apply patches by hand
(not with bk import), and as my "patch" knows about SCCS, it automatically
checks out files as needed. After that they are in "bk edit"  status, so
another bk edit just won't do anything.

So for me, it plays just well together.

(patch 2.5.4)

--Kai



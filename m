Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274255AbRI3X3N>; Sun, 30 Sep 2001 19:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274260AbRI3X3D>; Sun, 30 Sep 2001 19:29:03 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:42424
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S274255AbRI3X2v>; Sun, 30 Sep 2001 19:28:51 -0400
Date: Sun, 30 Sep 2001 16:28:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] cleanup of partition code
Message-ID: <20010930162856.A7768@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <Pine.GSO.4.21.0109301819220.12896-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109301819220.12896-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2001 at 06:31:55PM -0400, Alexander Viro wrote:

> 	Folks, _please_ help to test this one.  It switches most of
> the fs/partitions/* to use of pagecache, cleans it up and fixes quite
> a few holes in that area.
> 
> 	It should work in all cases when vanilla tree does.  Please,
> try it on different partitioning schemes.

Both my MS-DOS partition table and HFS partition table still work here
on a PPC box.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

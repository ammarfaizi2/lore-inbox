Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314893AbSDVWte>; Mon, 22 Apr 2002 18:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314894AbSDVWtd>; Mon, 22 Apr 2002 18:49:33 -0400
Received: from 216-42-72-164.ppp.netsville.net ([216.42.72.164]:1441 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S314893AbSDVWtc>; Mon, 22 Apr 2002 18:49:32 -0400
Subject: Re: XFS in the main kernel
From: Chris Mason <mason@suse.com>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020422221952.GB10813@merlin.emma.line.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 22 Apr 2002 18:47:59 -0400
Message-Id: <1019515679.16727.13.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-22 at 18:19, Matthias Andree wrote:

> Is there a test suite that checks POSIX (or better yet, SUS v3)
> compliance of a file system? That might prove useful, although I'm well
> aware it'd probably require some brains (and kernel modules) to check
> consistency guarantees. But apart from that, things like "truncate to
> zero length does not change the mtime of a file" (fixed in ReiserFS only
> some weeks ago) might get caught that way.

ftp://ftp.freestandards.org/pub/lsb/test_suites/

-chris



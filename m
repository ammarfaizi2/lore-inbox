Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317180AbSEXPoQ>; Fri, 24 May 2002 11:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314457AbSEXPoP>; Fri, 24 May 2002 11:44:15 -0400
Received: from imladris.infradead.org ([194.205.184.45]:13321 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317180AbSEXPoO>; Fri, 24 May 2002 11:44:14 -0400
Date: Fri, 24 May 2002 16:43:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jan Kara <jack@suse.cz>,
        Nathan Scott <nathans@sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: Quota patches
Message-ID: <20020524164327.A20050@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Jan Kara <jack@suse.cz>,
	Nathan Scott <nathans@sgi.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E17BHEJ-0006ed-00@the-village.bc.nu> <3CEE4ECB.5070603@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 04:31:39PM +0200, Martin Dalecki wrote:
> It is an illusion to think that you can actually run *that old*
> a.out binaries on a modern kernel I think.

Of course you can.  Even the latest OpenLinux release (shipping 2.4.13-ac)
uses a libc4/a.out based installer fo space reasons.  Not to forget the
old quake1 binary from some redhat 4.x CD I run from time to time :)


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281416AbRKEXPM>; Mon, 5 Nov 2001 18:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281418AbRKEXPC>; Mon, 5 Nov 2001 18:15:02 -0500
Received: from anime.net ([63.172.78.150]:34322 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S281421AbRKEXOu>;
	Mon, 5 Nov 2001 18:14:50 -0500
Date: Mon, 5 Nov 2001 15:14:14 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Andrew Morton <akpm@zip.com.au>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>,
        <ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <20011105154145.H3957@lynx.no>
Message-ID: <Pine.LNX.4.30.0111051513530.5784-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2001, Andreas Dilger wrote:
> There is a guy doing fragmentation testing for reiserfs.  It turns
> out that (in his tests) reiserfs can get 10x slower as the filesystem
> fills up because of intra-file fragmentation.  I don't know enough
> about reiserfs block/file allocation policy to know how this compares
> to ext2 at all.

How does xfs fare in comparison?

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]


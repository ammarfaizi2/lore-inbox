Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262622AbREOEhb>; Tue, 15 May 2001 00:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262625AbREOEhL>; Tue, 15 May 2001 00:37:11 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:22281 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S262622AbREOEhI>; Tue, 15 May 2001 00:37:08 -0400
Date: Tue, 15 May 2001 16:37:01 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
Message-ID: <20010515163701.A13399@metastasis.f00f.org>
In-Reply-To: <200105140117.f4E1HqN07362@vindaloo.ras.ucalgary.ca> <Pine.LNX.4.21.0105131824090.20981-100000@penguin.transmeta.com> <20010513184509.P2103@work.bitmover.com> <200105140239.f4E2dNd08399@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105140239.f4E2dNd08399@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Sun, May 13, 2001 at 08:39:23PM -0600
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 08:39:23PM -0600, Richard Gooch wrote:

    Yeah, we need a decent unfragmenter. We can do that now with
    bmap().

SCT wrote a defragger for ext2 but it only handles 1k blocks :(
Making it work for 4k blocks looked non-trivial to me, but smarter
people may not find it difficult at all.



  --cw

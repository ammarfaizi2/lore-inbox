Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135994AbRAJRjH>; Wed, 10 Jan 2001 12:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135996AbRAJRi6>; Wed, 10 Jan 2001 12:38:58 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24326 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135972AbRAJRio>; Wed, 10 Jan 2001 12:38:44 -0500
Date: Wed, 10 Jan 2001 18:38:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010110183852.N22197@athlon.random>
In-Reply-To: <20010110160359.E19503@athlon.random> <Pine.GSO.4.21.0101101216370.13614-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0101101216370.13614-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Jan 10, 2001 at 12:28:38PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 12:28:38PM -0500, Alexander Viro wrote:
> That's precisely what I've already done. grep for IS_DEADDIR() and notice

Fine ;)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

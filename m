Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLOWxl>; Fri, 15 Dec 2000 17:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129904AbQLOWxa>; Fri, 15 Dec 2000 17:53:30 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:25444 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129228AbQLOWxU>; Fri, 15 Dec 2000 17:53:20 -0500
Date: Fri, 15 Dec 2000 23:22:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: Ulrich Drepper <drepper@cygnus.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
Message-ID: <20001215232233.A21753@inspiron.random>
In-Reply-To: <200012152156.PAA137696@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200012152156.PAA137696@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Fri, Dec 15, 2000 at 03:56:52PM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 03:56:52PM -0600, Jesse Pollard wrote:
> [..] A null expression, specified with
> the ";" is a small price to pay for simplifying the error detection. [..]

I'm not convinced this is a significant simplification (also considering the
"hard" way is just working fine). I think it's only to be compliant with the
standard and despite me not liking having to duplicate even more information in
the sources, that's a good thing.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

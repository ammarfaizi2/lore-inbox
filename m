Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130199AbRAIOGp>; Tue, 9 Jan 2001 09:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130349AbRAIOGk>; Tue, 9 Jan 2001 09:06:40 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:64820 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130199AbRAIOGX>; Tue, 9 Jan 2001 09:06:23 -0500
Date: Tue, 9 Jan 2001 15:06:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010109150635.C8824@athlon.random>
In-Reply-To: <200101091341.HAA52016@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101091341.HAA52016@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Tue, Jan 09, 2001 at 07:41:21AM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 07:41:21AM -0600, Jesse Pollard wrote:
> Not exactly valid, since a file could be created in that "pinned" directory
> after the rmdir...

In 2.2.x no file can be created in the pinned directory after the rmdir.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRBCKKY>; Sat, 3 Feb 2001 05:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129547AbRBCKKF>; Sat, 3 Feb 2001 05:10:05 -0500
Received: from barnowl.demon.co.uk ([158.152.23.247]:41994 "EHLO
	barnowl.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129584AbRBCKJ4>; Sat, 3 Feb 2001 05:09:56 -0500
Mail-Copies-To: never
To: linux-kernel@vger.kernel.org
Subject: Re: Fix for include/linux/fs.h in 2.4.0 kernels
In-Reply-To: <14353.981190742@ocs3.ocs-net>
From: Graham Murray <graham@barnowl.demon.co.uk>
Date: 03 Feb 2001 10:09:39 +0000
In-Reply-To: <14353.981190742@ocs3.ocs-net> (Keith Owens's message of "Sat, 03 Feb 2001 19:59:02 +1100")
Message-ID: <m28znoulgc.fsf@barnowl.demon.co.uk>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

> This has all been thrashed out before.  Read the threads
> 
> http://www.mail-archive.com/linux-kernel@vger.rutgers.edu/2000-month-07/msg04096.html
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg18256.html

I don't think that these address my question. I was asking about when
building (upgrading) glibc from source. I believe that the glibc
headers are "derived" from the kernel against which it is built. So,
irrespective of what the glibc maintainers do, would it be advisable
for the user to remove the symlinks and copy the directories from the
kernel tree and into /usr/include?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

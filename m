Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKDAwH>; Fri, 3 Nov 2000 19:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKDAv5>; Fri, 3 Nov 2000 19:51:57 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8740 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129033AbQKDAvj>; Fri, 3 Nov 2000 19:51:39 -0500
Date: Sat, 4 Nov 2000 01:51:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Julian Anastasov <ja@ssi.bg>
Cc: Josue Emmanuel Amaro <Josue.Amaro@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Value of TASK_UNMAPPED_SIZE on 2.4
Message-ID: <20001104015110.A32767@athlon.random>
In-Reply-To: <Pine.LNX.4.04.10011040055420.834-200000@u>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.04.10011040055420.834-200000@u>; from ja@ssi.bg on Sat, Nov 04, 2000 at 01:09:42AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2000 at 01:09:42AM +0000, Julian Anastasov wrote:
> 	Something like the attached old patch for 2.2. It is very

It's not ok for 64bit archs.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

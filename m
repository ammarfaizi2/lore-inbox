Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129596AbQJaTPC>; Tue, 31 Oct 2000 14:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129473AbQJaTOm>; Tue, 31 Oct 2000 14:14:42 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:13896 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129371AbQJaTOk>; Tue, 31 Oct 2000 14:14:40 -0500
Date: Tue, 31 Oct 2000 20:13:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ulrich.Weigand@de.ibm.com
Cc: slpratt@us.ibm.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        linux-mm@kvack.org
Subject: Re: [PATCH] 2.4.0-test10-pre6 TLB flush race in establish_pte
Message-ID: <20001031201301.B9227@athlon.random>
In-Reply-To: <C1256989.0066C1B8.00@d12mta01.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C1256989.0066C1B8.00@d12mta01.de.ibm.com>; from Ulrich.Weigand@de.ibm.com on Tue, Oct 31, 2000 at 07:42:21PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 07:42:21PM +0100, Ulrich.Weigand@de.ibm.com wrote:
> IMO you should apply Steve's patch (without any #ifdef __s390__) now.

Agreed.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132517AbRAGOHM>; Sun, 7 Jan 2001 09:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132601AbRAGOHC>; Sun, 7 Jan 2001 09:07:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58126 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132517AbRAGOG5>; Sun, 7 Jan 2001 09:06:57 -0500
Subject: Re: Which kernel fixes the VM issues?
To: jim@browsermedia.com (Jim Olsen)
Date: Sun, 7 Jan 2001 14:08:24 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <01010706312902.10913@jim.cyberjunkees.com> from "Jim Olsen" at Jan 07, 2001 06:31:29 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FGUl-0002iH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> About once a week I get the 'VM: do_try_to_free_pages ...' error and 
> eventually get a complete system lockup. And just this morning it locked up 

Fixed in 2.2.19pre2

> again, although this time with a 'VFS: LRU block list corrupted' message in 
> the logs, which i'm assuming is related to the VM issue as well. 

Unrelated but believed fixed in 2.2.18


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129988AbQJaQVT>; Tue, 31 Oct 2000 11:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129963AbQJaQVN>; Tue, 31 Oct 2000 11:21:13 -0500
Received: from mg02.austin.ibm.com ([192.35.232.12]:37511 "EHLO
	mailgate2.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S129713AbQJaQVD>; Tue, 31 Oct 2000 11:21:03 -0500
Message-ID: <39FEF1F0.70822A87@us.ibm.com>
Date: Tue, 31 Oct 2000 10:23:12 -0600
From: Steven Pratt <slpratt@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvac.org
CC: Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] 2.4.0-test10-pre6  TLB flush race in establish_pte
In-Reply-To: <20001031013046.M21935@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Mon, Oct 30, 2000 at 03:31:22PM -0600, Steve Pratt/Austin/IBM wrote:
> > [..] no patch ever
> > appeared. [..]
> 
> You didn't followed l-k closely enough as the strict fix was submitted two
> times but it got not merged. (maybe because it had an #ifdef __s390__ that was
> _necessary_ by that time?)
> 
> You can find the old and now useless patch here:
> 
>ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.0-test5/tlb-flush-smp-race-1


I stand corrected, I missed this is my searching.  Hopefully this will
get in this time.

Steve
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

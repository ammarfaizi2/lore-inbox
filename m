Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130120AbQKFRng>; Mon, 6 Nov 2000 12:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130116AbQKFRn0>; Mon, 6 Nov 2000 12:43:26 -0500
Received: from TRAMPOLINE.THUNK.ORG ([216.175.175.172]:4868 "EHLO
	trampoline.thunk.org") by vger.kernel.org with ESMTP
	id <S130113AbQKFRnU>; Mon, 6 Nov 2000 12:43:20 -0500
Date: Mon, 6 Nov 2000 13:42:52 -0500
Message-Id: <200011061842.eA6Igqs16111@trampoline.thunk.org>
To: davem@redhat.com
CC: bsuparna@in.ibm.com, linux-kernel@vger.kernel.org, ak@suse.de,
        kanoj@google.engr.sgi.com
In-Reply-To: <200011060314.TAA22656@pizda.ninka.net> (davem@redhat.com)
Subject: Re: Oddness in i_shared_lock and page_table_lock nesting hierarchies ?
From: tytso@mit.edu
Phone: (781) 391-3464
In-Reply-To: <CA25698E.002082E9.00@d73mta05.au.ibm.com> <200011060314.TAA22656@pizda.ninka.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Sun, 5 Nov 2000 19:14:29 -0800
   From: "David S. Miller" <davem@redhat.com>

   It is a well known bug amongst gurus :-) I sent a linux24 bug addition
   to Ted Ty'tso a week or so ago but he dropped it aparently.

I got it, but I thought it was fixed before I had a chance to add it to
the bug list.  I got confused by one of Linus's descriptions of fixes to
the test10-pre* series.

Sorry; my bad.  I'll get it added to the list.

						- Ted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

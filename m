Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282444AbRK0AeZ>; Mon, 26 Nov 2001 19:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282679AbRK0AeP>; Mon, 26 Nov 2001 19:34:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:15235 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282444AbRK0AeD>;
	Mon, 26 Nov 2001 19:34:03 -0500
Date: Mon, 26 Nov 2001 16:33:54 -0800 (PST)
Message-Id: <20011126.163354.54183516.davem@redhat.com>
To: neilb@cse.unsw.edu.au
Cc: trond.myklebust@fys.uio.no, nfs@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Fix knfsd readahead cache in 2.4.15
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15362.56955.812017.103343@esther.cse.unsw.edu.au>
In-Reply-To: <15362.53694.192797.275363@esther.cse.unsw.edu.au>
	<20011126.155347.45872112.davem@redhat.com>
	<15362.56955.812017.103343@esther.cse.unsw.edu.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Neil Brown <neilb@cse.unsw.edu.au>
   Date: Tue, 27 Nov 2001 11:29:47 +1100 (EST)

   I don't think your patch adds anything.
   Re-writing the code to use list.h lists would probably be useful
   But currently (except of the problem Trond found) the code is correct.

You're right.

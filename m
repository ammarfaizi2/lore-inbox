Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293276AbSDUEJB>; Sun, 21 Apr 2002 00:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310214AbSDUEJA>; Sun, 21 Apr 2002 00:09:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8393 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293276AbSDUEJA>;
	Sun, 21 Apr 2002 00:09:00 -0400
Date: Sat, 20 Apr 2002 20:59:58 -0700 (PDT)
Message-Id: <20020420.205958.123241031.davem@redhat.com>
To: viro@math.psu.edu
Cc: torvalds@transmeta.com, spyro@armlinux.org, linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.21.0204202347010.27210-100000@weyl.math.psu.edu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alexander Viro <viro@math.psu.edu>
   Date: Sun, 21 Apr 2002 00:05:27 -0400 (EDT)

   FWIW, I doubt that dropping -pre completely in favour of dayly snapshots is
   a good idea - "2.5.N-preM oopses when ..." is preferable to "snapshot YY/MM/DD
   oopses when..." simply because it's easier to match bug reports that way.
   Having all deltas downloadable as diff+comment is wonderful, but it doesn't
   replace well-defined (and less frequent) resync points.
   
   Comments?

I agree, make the daily's available but don't kill the -pre.

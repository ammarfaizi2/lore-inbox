Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319217AbSHMXrk>; Tue, 13 Aug 2002 19:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319218AbSHMXrk>; Tue, 13 Aug 2002 19:47:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48299 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319217AbSHMXrj>;
	Tue, 13 Aug 2002 19:47:39 -0400
Date: Tue, 13 Aug 2002 16:37:46 -0700 (PDT)
Message-Id: <20020813.163746.98327763.davem@redhat.com>
To: neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2 NFS OOPS on sparc64
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15705.34786.933680.708535@notabene.cse.unsw.edu.au>
References: <Pine.GSO.4.43.0208131916340.16824-100000@romulus.cs.ut.ee>
	<20020813.102737.04335380.davem@redhat.com>
	<15705.34786.933680.708535@notabene.cse.unsw.edu.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Neil Brown <neilb@cse.unsw.edu.au>
   Date: Wed, 14 Aug 2002 08:27:46 +1000

   Now if only Linus has told me (like you did) instead of just making
   the change himself in 2.5, I would have got it right in 2.4..
   
Non-long pointers sent to bitops get a warning in 2.5.x so it just
automatically shows up in the build logs there.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318988AbSHFExI>; Tue, 6 Aug 2002 00:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318989AbSHFExI>; Tue, 6 Aug 2002 00:53:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30409 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318988AbSHFExH>;
	Tue, 6 Aug 2002 00:53:07 -0400
Date: Mon, 05 Aug 2002 21:43:38 -0700 (PDT)
Message-Id: <20020805.214338.22455123.davem@redhat.com>
To: kuznet@ms2.inr.ac.ru
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: Fragment flooding in 2.4.x/2.5.x
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200208052330.DAA22912@sex.inr.ac.ru>
References: <15694.33047.965504.346909@charged.uio.no>
	<200208052330.DAA22912@sex.inr.ac.ru>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: kuznet@ms2.inr.ac.ru
   Date: Tue, 6 Aug 2002 03:30:53 +0400 (MSD)

   >		 the bug has already been known to crash a few
   > servers...
   
   Sorry? What crash do you speak about?

If you partial-fragment bomb NFS servers from a certain
vendor, they hard hang :-)

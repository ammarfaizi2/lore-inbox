Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319671AbSH3VaN>; Fri, 30 Aug 2002 17:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319673AbSH3VaN>; Fri, 30 Aug 2002 17:30:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30130 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319671AbSH3VaM>;
	Fri, 30 Aug 2002 17:30:12 -0400
Date: Fri, 30 Aug 2002 14:28:33 -0700 (PDT)
Message-Id: <20020830.142833.118548108.davem@redhat.com>
To: cel@citi.umich.edu
Cc: marcelo@plucky.distro.conectiva, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [PATCH] sock_writeable not appropriate for TCP sockets, for
 2.4.20
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0208301648230.1645-100000@dexter.citi.umich.edu>
References: <Pine.LNX.4.44.0208301648230.1645-100000@dexter.citi.umich.edu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Chuck Lever <cel@citi.umich.edu>
   Date: Fri, 30 Aug 2002 16:51:57 -0400 (EDT)

   patch reviewed by Trond and Alexey.  patch already sent to linus for 2.5.
   
I think this patch should go in too.
   
   --- 2.4.20-pre5/net/sunrpc/xprt.c.orig	Fri Aug 30 15:49:28 2002
   +++ 2.4.20-pre5/net/sunrpc/xprt.c	Fri Aug 30 15:52:55 2002

Franks a lot,
David S. Miller
davem@redhat.com

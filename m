Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291913AbSBAS7b>; Fri, 1 Feb 2002 13:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291915AbSBAS7Z>; Fri, 1 Feb 2002 13:59:25 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:12296 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S291913AbSBAS7L>;
	Fri, 1 Feb 2002 13:59:11 -0500
Date: Sat, 2 Feb 2002 05:38:46 +1100
From: Anton Blanchard <anton@samba.org>
To: Momchil Velikov <velco@fadata.bg>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>, John Stoffel <stoffel@casc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020201183846.GA18790@krispykreme>
In-Reply-To: <Pine.LNX.4.33.0201311115450.1732-100000@penguin.transmeta.com> <Pine.LNX.4.33.0201312227350.18203-100000@localhost.localdomain> <20020131231242.GA4138@krispykreme> <878zad1zlj.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878zad1zlj.fsf@fadata.bg>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> A correction, "-splay" is the very first variant I posted, which used
> splay trees for the page cache.

Oops now I remember why I called it -splay :) I have a radix comparison
somewhere, I'll fish it out.

Anton

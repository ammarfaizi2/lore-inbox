Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315185AbSD3VaJ>; Tue, 30 Apr 2002 17:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315213AbSD3VaI>; Tue, 30 Apr 2002 17:30:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14027 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315185AbSD3VaI>;
	Tue, 30 Apr 2002 17:30:08 -0400
Date: Tue, 30 Apr 2002 14:19:39 -0700 (PDT)
Message-Id: <20020430.141939.46853738.davem@redhat.com>
To: bruce.holzrichter@monster.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: pgtable.h in Sparc64
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <61DB42B180EAB34E9D28346C11535A7817806A@nocmail101.ma.tmpw.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
   Date: Tue, 30 Apr 2002 13:32:44 -0500

   Are you already splitting out the stuff to make a cacheflush.h and
   tlbflush.h from asm-sparc64/pgtable.h?  It doesn't look to be to bad a
   split, to keep the build working.  

I have done all of this work already, I just haven't merged it to
Linus yet.  In fact I did this two weeks ago.

I've just been really busy...

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315672AbSEIKBZ>; Thu, 9 May 2002 06:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315674AbSEIKBY>; Thu, 9 May 2002 06:01:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5554 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315672AbSEIKBX>;
	Thu, 9 May 2002 06:01:23 -0400
Date: Thu, 09 May 2002 02:49:12 -0700 (PDT)
Message-Id: <20020509.024912.14048739.davem@redhat.com>
To: hch@infradead.org
Cc: dank@kegel.com, arjanv@redhat.com, marcelo@conectiva.com.br,
        khttpd-users@alt.org, linux-kernel@vger.kernel.org
Subject: Re: khttpd rotten?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020506112259.A25629@infradead.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@infradead.org>
   Date: Mon, 6 May 2002 11:23:00 +0100

   On Sun, May 05, 2002 at 07:39:42PM -0700, Dan Kegel wrote:
   > Right.  If khttpd had been pulled from 2.4.17, I would have
   > had weeks of warning that khttpd is unstable; instead, I learned
   > only when someone started doing his own stress testing, and I
   > have little time to fix it.  I say pull it from
   > 2.4.19-pre9.  Marcello, put it out of its misery asap, please...
   > it'd time for khttpd to become a standalone patch again.
   
   Okay, what about the following:

Are you willing to start being the khttp maintainer?

I have not seen updates or any attempts at maintaining the
thing in about 2 years.  Basically, since it went into the
tree.

If we aren't changing that situation, we are not removing
the impetus for taking khttpd out of the tree entirely.

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316416AbSETWUY>; Mon, 20 May 2002 18:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316420AbSETWUY>; Mon, 20 May 2002 18:20:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1986 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316416AbSETWUX>;
	Mon, 20 May 2002 18:20:23 -0400
Date: Mon, 20 May 2002 15:06:28 -0700 (PDT)
Message-Id: <20020520.150628.25332319.davem@redhat.com>
To: hch@infradead.org
Cc: beezly@beezly.org.uk, linux-kernel@vger.kernel.org
Subject: Re: OOPS: ext3/sparc badness
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020520225206.A15153@infradead.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@infradead.org>
   Date: Mon, 20 May 2002 22:52:06 +0100

   On Mon, May 20, 2002 at 02:30:18PM -0700, David S. Miller wrote:
   > Unsupported compiler for sparc64 kernels.  Your OOPS report is going
   > to be ignored.
   
   Btw, is gcc 3.1 supported now or only the magic egcs variant?
   
gcc-3.1 should work properly, I've used it but I'm hesitant to %100
bless it just yet. :-)

I would prefer to receive bug reports only against the sparc64-egcs
compiler still.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277059AbRJKX2O>; Thu, 11 Oct 2001 19:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277068AbRJKX2I>; Thu, 11 Oct 2001 19:28:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14721 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277059AbRJKX17>;
	Thu, 11 Oct 2001 19:27:59 -0400
Date: Thu, 11 Oct 2001 16:28:10 -0700 (PDT)
Message-Id: <20011011.162810.74562729.davem@redhat.com>
To: viro@math.psu.edu
Cc: jgarzik@mandrakesoft.com, chris@chrullrich.de, torvalds@transmeta.com,
        v.sweeney@dexterus.com, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Subject: Re: Partitioning problems in 2.4.11
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.21.0110111919110.24742-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.LNX.3.96.1011011180912.5934I-100000@mandrakesoft.mandrakesoft.com>
	<Pine.GSO.4.21.0110111919110.24742-100000@weyl.math.psu.edu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alexander Viro <viro@math.psu.edu>
   Date: Thu, 11 Oct 2001 19:22:25 -0400 (EDT)

   On Thu, 11 Oct 2001, Jeff Garzik wrote:
   
   > To tangent, do we really need a mount cache that big, even on a highmem
   > machine?
   
   Probably not - feel free to cut it down.

Yikes, ignore my previous email, I misread and thought Jeff was
talking about the page cache hashes :)

Franks a lot,
David S. Miller
davem@redhat.com

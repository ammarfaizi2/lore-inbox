Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272077AbRHWBJK>; Wed, 22 Aug 2001 21:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272073AbRHWBJA>; Wed, 22 Aug 2001 21:09:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36738 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272077AbRHWBIz>;
	Wed, 22 Aug 2001 21:08:55 -0400
Date: Wed, 22 Aug 2001 18:08:58 -0700 (PDT)
Message-Id: <20010822.180858.89278064.davem@redhat.com>
To: gibbs@scsiguy.com
Cc: groudier@free.fr, axboe@suse.de, skraw@ithnet.com, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200108230055.f7N0tLY20934@aslan.scsiguy.com>
In-Reply-To: <20010822.174048.116352248.davem@redhat.com>
	<200108230055.f7N0tLY20934@aslan.scsiguy.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
   Date: Wed, 22 Aug 2001 18:55:21 -0600
   
   Then it is poorly named.  How about "pci_dma32_t".  Or better yet,
   uint32_t.  How do the guys writing SBUS drivers like the fact that
   all of this mapping stuff is so PCI centric?
   
Please actually take a look at a few SBUS drivers before
you open your big mouth.  SBUS drivers use a totally different
API.

Later,
David S. Miller
davem@redhat.com

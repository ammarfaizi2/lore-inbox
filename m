Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271399AbRICIQD>; Mon, 3 Sep 2001 04:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271505AbRICIPx>; Mon, 3 Sep 2001 04:15:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37258 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271399AbRICIPi>;
	Mon, 3 Sep 2001 04:15:38 -0400
Date: Mon, 03 Sep 2001 01:15:30 -0700 (PDT)
Message-Id: <20010903.011530.62340995.davem@redhat.com>
To: ak@suse.de
Cc: alan@lxorguk.ukuu.org.uk, willy@debian.org, thunder7@xs4all.nl,
        parisc-linux@lists.parisc-linux.org, linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] documented Oops running big-endian reiserfs on
 parisc architecture
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <oup66b0zq9j.fsf@pigdrop.muc.suse.de>
In-Reply-To: <20010903002514.X5126@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
	<E15dghq-0000bZ-00@the-village.bc.nu.suse.lists.linux.kernel>
	<oup66b0zq9j.fsf@pigdrop.muc.suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 03 Sep 2001 09:29:12 +0200
   
   And also everybody connected to the internet needs them, because you can 
   create arbitarily unaligned TCP/UDP/ICMP headers using IP option byte sized 
   NOPs. 

IP header length is measured in octets, so how is this possible?
:-)

Later,
David S. Miller
davem@redhat.com

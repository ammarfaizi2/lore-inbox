Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272441AbRISWW3>; Wed, 19 Sep 2001 18:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274226AbRISWWT>; Wed, 19 Sep 2001 18:22:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5768 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272441AbRISWWD>;
	Wed, 19 Sep 2001 18:22:03 -0400
Date: Wed, 19 Sep 2001 15:21:18 -0700 (PDT)
Message-Id: <20010919.152118.78708122.davem@redhat.com>
To: rfuller@nsisoftware.com
Cc: ebiederm@xmission.com, alan@lxorguk.ukuu.org.uk, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: broken VM in 2.4.10-pre9
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <878A2048A35CD141AD5FC92C6B776E4907B7A5@xchgind02.nsisw.com>
In-Reply-To: <878A2048A35CD141AD5FC92C6B776E4907B7A5@xchgind02.nsisw.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Rob Fuller" <rfuller@nsisoftware.com>
   Date: Wed, 19 Sep 2001 17:15:21 -0500
   
   I suppose I confused the issue when I offered a supporting argument for
   reverse mappings.  It's not reverse mappings for anonymous pages I'm
   advocating, but reverse mappings for mapped file data.

We already have reverse mappings for files, via the VMA chain off the
inode.

Later,
David S. Miller
davem@redhat.com

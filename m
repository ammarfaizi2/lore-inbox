Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270319AbRIBX0i>; Sun, 2 Sep 2001 19:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270333AbRIBX02>; Sun, 2 Sep 2001 19:26:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33926 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270319AbRIBX0U>;
	Sun, 2 Sep 2001 19:26:20 -0400
Date: Sun, 02 Sep 2001 16:26:32 -0700 (PDT)
Message-Id: <20010902.162632.55510336.davem@redhat.com>
To: willy@debian.org
Cc: thunder7@xs4all.nl, parisc-linux@lists.parisc-linux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] documented Oops running big-endian reiserfs on
 parisc architecture
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010903002514.X5126@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20010902150023.U5126@parcelfarce.linux.theplanet.co.uk>
	<20010902.160441.92583890.davem@redhat.com>
	<20010903002514.X5126@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matthew Wilcox <willy@debian.org>
   Date: Mon, 3 Sep 2001 00:25:14 +0100
   
   No, we just haven't bothered to implement it yet.  Not many people
   use IPX these days.
   
IPX is not the only way this can happen.  Normal IPv4 can get
it with some ethernet cards on receive.

Later,
David S. Miller
davem@redhat.com

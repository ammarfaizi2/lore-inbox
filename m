Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272521AbSIST1V>; Thu, 19 Sep 2002 15:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272522AbSIST03>; Thu, 19 Sep 2002 15:26:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49813 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272521AbSIST0U>;
	Thu, 19 Sep 2002 15:26:20 -0400
Date: Thu, 19 Sep 2002 12:21:27 -0700 (PDT)
Message-Id: <20020919.122127.75273267.davem@redhat.com>
To: mroos@math.ut.ee
Cc: roger@computer-surgery.co.uk, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org, cbyrum@spamaps.org
Subject: Re: Linux TCP problem while talking to hostme.bkbits.net ?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.44.0209191614360.24450-100000@math.ut.ee>
References: <20020813133159.A21210@computer-surgery.co.uk>
	<Pine.GSO.4.44.0209191614360.24450-100000@math.ut.ee>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Meelis Roos <mroos@math.ut.ee>
   Date: Thu, 19 Sep 2002 16:15:52 +0300 (EEST)

   > I've seen these sort of symptoms before and it turned out
   > to be faulty memory.
   
   The mystery has been solved - after the symptoms appeared again (this
   time certain outgoing packets didn't get through), I ran memtest86 for
   night and it showed bad memory.
   
Thanks for following up on this.

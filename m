Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262403AbSI2GZK>; Sun, 29 Sep 2002 02:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262404AbSI2GZK>; Sun, 29 Sep 2002 02:25:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3491 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262403AbSI2GZJ>;
	Sun, 29 Sep 2002 02:25:09 -0400
Date: Sat, 28 Sep 2002 23:23:50 -0700 (PDT)
Message-Id: <20020928.232350.33317317.davem@redhat.com>
To: szepe@pinerecords.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: sparc32 sunrpc.o
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020928161316.GA4323@louise.pinerecords.com>
References: <20020926.142910.124086325.davem@redhat.com>
	<20020928122817.GV27082@louise.pinerecords.com>
	<20020928161316.GA4323@louise.pinerecords.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tomas Szepe <szepe@pinerecords.com>
   Date: Sat, 28 Sep 2002 18:13:16 +0200

   > Ok, DaveM, could you have a look at this patch?
   
   Please disregard, highmem.c unreasonably included linux/highmem.h.
   I'll be looking into this some more.
   
Let us know when new working patch is available :-)

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSFLUVY>; Wed, 12 Jun 2002 16:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314243AbSFLUVY>; Wed, 12 Jun 2002 16:21:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24276 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315260AbSFLUUr>;
	Wed, 12 Jun 2002 16:20:47 -0400
Date: Wed, 12 Jun 2002 13:16:20 -0700 (PDT)
Message-Id: <20020612.131620.108488067.davem@redhat.com>
To: pavel@ucw.cz
Cc: oliver@neukum.name, roland@topspin.com, wjhun@ayrnetworks.com,
        paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020612090639.GB986@elf.ucw.cz>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pavel Machek <pavel@ucw.cz>
   Date: Wed, 12 Jun 2002 11:06:39 +0200
   
   But upper bound is certainly known at compile time, right?

That's true.

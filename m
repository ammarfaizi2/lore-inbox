Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281642AbRKPXFn>; Fri, 16 Nov 2001 18:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281641AbRKPXFd>; Fri, 16 Nov 2001 18:05:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7043 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281642AbRKPXFW>;
	Fri, 16 Nov 2001 18:05:22 -0500
Date: Fri, 16 Nov 2001 15:05:16 -0800 (PST)
Message-Id: <20011116.150516.105434270.davem@redhat.com>
To: axboe@suse.de
Cc: groudier@free.fr, linux-kernel@vger.kernel.org
Subject: Re: [patch] block-highmem-all-18
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011116234555.C11826@suse.de>
In-Reply-To: <20011116193057.O1825-100000@gerard>
	<20011116.135409.118971851.davem@redhat.com>
	<20011116234555.C11826@suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Fri, 16 Nov 2001 23:45:55 +0100
   
   it was introduced before we supported full 64-bit
   dma, and should now just be called can_highmem_io or something
   similar.

I encourage you to make this change :-)


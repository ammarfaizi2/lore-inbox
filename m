Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132869AbRDDRxj>; Wed, 4 Apr 2001 13:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132871AbRDDRx3>; Wed, 4 Apr 2001 13:53:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60430 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132869AbRDDRxV>; Wed, 4 Apr 2001 13:53:21 -0400
Subject: Re: 2.4 kernel hangs on 486 machine at boot
To: vik.heyndrickx@pandora.be (Vik Heyndrickx)
Date: Wed, 4 Apr 2001 18:54:14 +0100 (BST)
Cc: rhw@memalpha.cx, linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
In-Reply-To: <000701c0bd17$1232f200$04a8a8c0@vortex.prv> from "Vik Heyndrickx" at Apr 04, 2001 04:53:54 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14krU0-0002P8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Problem: Linux kernel 2.4 consistently hangs at boot on 486 machine
> 
> Shortly after lilo starts the kernel it hangs at the following message:
> Checking if this processor honours the WP bit even in supervisor mode...
> <blinking cursor>

Does this happen on 2.4.3-ac kernel trees ? I thought i had it zapped

> 


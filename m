Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVCLFY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVCLFY0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 00:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVCLFYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 00:24:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:10414 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262768AbVCLFYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 00:24:03 -0500
Date: Fri, 11 Mar 2005 21:19:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org,
       Felix von Leitner <felix-linuxkernel@fefe.de>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino
 speedstep even more broken than in 2.6.10
Message-Id: <20050311211908.434baba1.akpm@osdl.org>
In-Reply-To: <423278D6.2090603@shaw.ca>
References: <3GZyA-16B-17@gated-at.bofh.it>
	<423278D6.2090603@shaw.ca>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Restoring email headers.  Please always use reply-to-all)

Robert Hancock <hancockr@shaw.ca> wrote:
>
> Felix von Leitner wrote:
> > My new nForce 4 mainboard has 10 or so USB 2.0 outlets.  In Windows,
> > they all work.  In Linux, two of them work.  Putting my USB stick or
> > anything else in one of the others produces nothing in Linux.
> > Apparently no IRQ getting through or something?
> 
> Likely similar to the problem I reported in this thread on 
> linux-usb-devel - the patch that David Brownell posted fixed the problem 
> for me..
> 
> http://sourceforge.net/mailarchive/message.php?msg_id=10755097
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

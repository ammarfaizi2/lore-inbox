Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbRFRNSh>; Mon, 18 Jun 2001 09:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262707AbRFRNS3>; Mon, 18 Jun 2001 09:18:29 -0400
Received: from [203.143.19.4] ([203.143.19.4]:36362 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S262835AbRFRNSL>;
	Mon, 18 Jun 2001 09:18:11 -0400
Date: Mon, 18 Jun 2001 19:17:09 +0600
To: linux-kernel@vger.kernel.org
Subject: Unresolved symbol do_softirq in 2.4.6-pre3
Message-ID: <20010618191709.A711@bee.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Anuradha Ratnaweera <anuradha@bee.lk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I started running 2.4.6-pre3 using the same configuration file as 2.4.5.
Diff shows no effective differences between two config files.

depmod complains unresolved symbols (do_softirq) in ppp_generic, ppp_async
and sunrpc.

do_softirq is listed in System.map-2.4.6-pre3.

I started with a new source tree and built the kernel with Debian kernel
package.

Any comment? Thanks in advance.

Regards,

Anuradha

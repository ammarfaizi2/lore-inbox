Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272605AbTG1Akn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272611AbTG1AjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:39:09 -0400
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:42758 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S272607AbTG1AiH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 20:38:07 -0400
Message-ID: <200307280253090799.10BB2DF0@192.168.128.16>
In-Reply-To: <20030727173600.475d95fb.davem@redhat.com>
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com>
 <200307280140470646.1078EC67@192.168.128.16>
 <20030727164649.517b2b88.davem@redhat.com>
 <200307280158250677.10891156@192.168.128.16>
 <20030727165831.05904792.davem@redhat.com>
 <200307280211590888.10957DD9@192.168.128.16>
 <20030727171403.6e5bcc58.davem@redhat.com>
 <200307280235210263.10AADFF8@192.168.128.16>
 <20030727173600.475d95fb.davem@redhat.com>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Mon, 28 Jul 2003 02:53:09 +0200
From: "Carlos Velasco" <carlosev@newipnet.com>
To: "David S. Miller" <davem@redhat.com>
Cc: bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2003 at 17:36 David S. Miller wrote:

>> The easy way is the "hidden" patch, if it's applied in the kernel.
>
>Not true, anyone is free to design a graphical GUI or shell script (or
>even a wrapper for the /sbin/ip tool) that gives you the default
>behavior you want, without any user interaction whatsoever.

Anyone is free to do many things.
But if the hidden patch and /proc switch would be in the main kernel,
it would be the simpliest way to solve all these "problems" (with an
echo "1" and without filtering or using iproute2).

Regards,
Carlos Velasco
 


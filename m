Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbULAVMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbULAVMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbULAVMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:12:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:33924 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261440AbULAVMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:12:03 -0500
Date: Wed, 1 Dec 2004 13:11:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Auke Kok <sofar@lunar-linux.org>
Cc: linux-kernel@vger.kernel.org, vortex@scyld.com,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH][2.4.28-pre3] 3c59x builtin NIC on Asus Pundit-R
Message-Id: <20041201131127.208e15b6.akpm@osdl.org>
In-Reply-To: <41AE2661.2040408@lunar-linux.org>
References: <41AE2661.2040408@lunar-linux.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auke Kok <sofar@lunar-linux.org> wrote:
>
> 
> This message is a confirmation on the thread by:
> 
> From: Andreas Haumer
> Date: Tue Sep 21 2004 - 04:16:52 EST
> Subject: [PATCH][2.4.28-pre3] 3c59x builtin NIC on Asus Pundit-R
> 
> I have 24 boxes with the same hardware and all require the patch 
> attached to Andreas' e-mail to function. After abusing one of them for 2 
> days continuously the nic hasn't shown a single flaw so far ;^)
> 
> I thus would like to conclude that this patch is a valid and worthfull 
> addition to the 2.4.28+ kernels, as it applies cleanly to 2.4.28-final.
> 
> Auke kok
> 
> 
> PS URL to the patch: 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0409.2/1215/013-3com_ati_radeon.patch

That patch should of course be merged.  Please email a copy to Marcelo.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270773AbTG0Mu6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 08:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270774AbTG0Mu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 08:50:57 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:7428 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S270773AbTG0Mu4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 08:50:56 -0400
Date: Sun, 27 Jul 2003 15:05:24 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Ihar Philips Filipau <filia@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT: Vanilla not for embedded?! Re: Kernel 2.6 size increase - get_current()?
Message-ID: <20030727150524.A23878@electric-eye.fr.zoreil.com>
References: <dbTZ.5Z5.19@gated-at.bofh.it> <3F214EC3.9010804@softhome.net> <20030725204613.GB1686@matchmail.com> <3F23BE18.5000600@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F23BE18.5000600@softhome.net>; from filia@softhome.net on Sun, Jul 27, 2003 at 01:57:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ihar Philips Filipau <filia@softhome.net> :
[...]
>    Patches to remove mandatory (for 2.2/2.0) PCI/IDE support were pretty 
> common too.
>    Patch to shrink network hashes - norm of life.
>    Patch to kill PCI names database.
>    And this is only things I was using personally (and I remember about) 
> in my short 4 years carrier.

Would you mind publishing the patches ?

>    CONFIG_TINY - http://lwn.net/Articles/14186/ - got something like 
> this merged? - so I'm the first guy in the download queue on ftp.kernel.org!

See CONFIG_EMBEDDED.

[...]
>    For some reasons all "improvements" to kernel had lead to increase of 
> kernel size, not decrease. Strange, isn't it?

No time for sarcasm here.

Regards

--
Ueimor

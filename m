Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbTJTMLg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 08:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbTJTMLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 08:11:36 -0400
Received: from cibs9.sns.it ([192.167.206.29]:35599 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S262555AbTJTMLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 08:11:33 -0400
Date: Mon, 20 Oct 2003 14:11:29 +0200 (CEST)
From: venom@sns.it
To: Chris Anderson <chris@simoniac.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Module problems with NVIDIA and 2.6.0-test8?
In-Reply-To: <1066649707.22658.4.camel@kuso>
Message-ID: <Pine.LNX.4.43.0310201410410.27849-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

which version of nvidia driver are you using.
1.0-3123 works just fine with test8.


On Mon, 20 Oct 2003, Chris Anderson wrote:

> Date: Mon, 20 Oct 2003 07:35:08 -0400
> From: Chris Anderson <chris@simoniac.com>
> To: linux-kernel@vger.kernel.org
> Subject: Module problems with NVIDIA and 2.6.0-test8?
>
> I recently built test8 and also the NVIDIA driver using the patches from
> minion.de. The compile had no errors and I can load the module without
> errors as well (aside from the "NVIDIA taints the kernel" message).
> However, even with the module loaded, X says it cannot initialize it and
> acts exactly as if the module was never there. Not much is left to work
> with in the logs so frankly I'm stumped. The system works fine with the
> "nv" driver and I had the driver working in test1. Has anyone else
> experienced a problem like this?
>
> Log: www.simoniac.com/~chris/XFree86.0.log
>
> Config: www.simoniac.com/~chris/XF86Config-4
>
> -Chris
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


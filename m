Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267549AbUIJQPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267549AbUIJQPM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267558AbUIJQMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:12:40 -0400
Received: from [217.132.60.104] ([217.132.60.104]:39298 "EHLO localhost")
	by vger.kernel.org with ESMTP id S267527AbUIJPsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:48:24 -0400
Date: Fri, 10 Sep 2004 19:51:04 +0300
From: SashaK <sashak@smlink.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97 
 patch)
Message-ID: <20040910195104.49abd61b@localhost>
In-Reply-To: <2CAhw-4dR-3@gated-at.bofh.it>
References: <2CvrA-Fv-11@gated-at.bofh.it>
	<2CAhw-4dR-3@gated-at.bofh.it>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Sep 2004 18:50:06 +0200
Theodore Ts'o <tytso@mit.edu> wrote:

> The good news is that there a completely GPL'ed, source-complete
> driver already in the 2.6 kernel, sound/pci/intel8x0m.c, which will
> work with  the user-mode daemon found in the smlink.com distribution.
> This driver doesn't have all of the functionality of slamr driver
> (which requires the propietary, binary-only object file) --- most
> notably, ATM1 doesn't work when using the completely open-source
> intl8x0m driver.

Those functionality limitations in open source modem drivers are just
"unimplemented yet" stuff. The final goal is to replace proprietary
slamr driver completely.

Best Regards,
Sasha.

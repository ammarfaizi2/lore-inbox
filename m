Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVDXU1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVDXU1I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 16:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVDXU1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 16:27:08 -0400
Received: from curlew.cs.man.ac.uk ([130.88.13.7]:40199 "EHLO
	curlew.cs.man.ac.uk") by vger.kernel.org with ESMTP id S262402AbVDXU0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 16:26:50 -0400
Message-ID: <426C01CC.7050602@gentoo.org>
Date: Sun, 24 Apr 2005 21:30:04 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050403)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH-remove experimental depends from forcedeth
References: <200503051106.11678.gene.heskett@verizon.net>
In-Reply-To: <200503051106.11678.gene.heskett@verizon.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1DPngk-000NlX-36*JJK9T/WxaUc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> I've not seen a forcedeth mention go by on this list for quite some
> time unless I made it.  It has been quite bulletproof here so I don't 
> feel the need for it to remain dependent on the experimental status in 
> the main .config.
> 
> Hence this patch to remove that requirement from the appropriate 
> Kconfig.

I know of one issue that remains, which seems to have hit a few Gentoo users.

See
http://www.ussg.iu.edu/hypermail/linux/kernel/0502.0/0219.html
and
http://bugs.gentoo.org/90069

It's been reported to this mailing list, but I've also asked the affected
Gentoo users to file a bug at the kernel bugzilla.

Daniel

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTEWHB4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 03:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTEWHB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 03:01:56 -0400
Received: from aktion1.adns.de ([62.116.145.13]:34972 "EHLO aktion1.adns.de")
	by vger.kernel.org with ESMTP id S263726AbTEWHBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 03:01:55 -0400
Message-ID: <3ECDCA64.3090604@web.de>
Date: Fri, 23 May 2003 09:14:44 +0200
From: Sven Krohlas <darkshadow@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4b) Gecko/20030516
X-Accept-Language: de, de-at, de-de, de-li, de-lu, de-ch, en-us, en
MIME-Version: 1.0
To: Oliver Pitzeier <o.pitzeier@uptime.at>
CC: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
References: <004a01c32075$7e2a7500$020b10ac@pitzeier.priv.at>
In-Reply-To: <004a01c32075$7e2a7500$020b10ac@pitzeier.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> You didn't see a kernel panic as well? I'm asking, because I have the same
> problems with one of my machines...

No panic, nothing in the logs.


> When was this problem introduced? Does 2.4.19, or 2.4.20 work well?

2.4.19 & .20 worked "fine", well, at least without DMA mode. But they
are stable.


> It's also a SCSI-only system if this does matter...

Well, my system got a SCSI card, too, but no hardware at all is connected
to it:
SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 26)

Have a nice day.
-- 
BOFH excuse of the day:
The salesman drove over the CPU board.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266621AbTGFHQI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 03:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbTGFHQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 03:16:07 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:1184
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266621AbTGFHQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 03:16:06 -0400
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ben Greear <greearb@candelatech.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jeff Sipek <jeffpc@optonline.net>,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, netdev@oss.sgi.com
In-Reply-To: <3F0745EC.1060204@candelatech.com>
References: <E19YtAq-0006Xf-00@calista.inka.de>
	 <200307051637.52252.jeffpc@optonline.net> <3F0737D1.5090109@pobox.com>
	 <3F0745EC.1060204@candelatech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057476433.700.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Jul 2003 08:27:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-05 at 22:41, Ben Greear wrote:
> Untill the net-stats are 64-bit on 32-bit systems, we will need some
> way to know if they have wrapped or not when reading from nettool
> and getting 64-bit numbers.

iptables

Collecting the data on a need to know basis 8)


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266405AbTGEU0k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 16:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266497AbTGEU0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 16:26:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19907 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266405AbTGEU0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 16:26:32 -0400
Message-ID: <3F0737D1.5090109@pobox.com>
Date: Sat, 05 Jul 2003 16:40:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Sipek <jeffpc@optonline.net>
CC: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, netdev@oss.sgi.com
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
References: <E19YtAq-0006Xf-00@calista.inka.de> <200307051637.52252.jeffpc@optonline.net>
In-Reply-To: <200307051637.52252.jeffpc@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The net stats are already unsigned long internally.

64-bit case is handled quite nicely today, thanks :)

I'm such a 64-bit bigot that "buy a 64-bit computer" is a solution I 
commonly suggest, and it seems to fit well here, too.

	Jeff, wondering if Intel will bother to compete w/ Athlon64




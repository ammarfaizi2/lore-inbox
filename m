Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289697AbSAJVcd>; Thu, 10 Jan 2002 16:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289695AbSAJVcX>; Thu, 10 Jan 2002 16:32:23 -0500
Received: from quechua.inka.de ([212.227.14.2]:11820 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S289696AbSAJVcN>;
	Thu, 10 Jan 2002 16:32:13 -0500
From: Bernd Eckenfels <ecki-news2002-01@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: eth0: entered promiscuous mode
In-Reply-To: <20020110205946.GB24838@zhadum.bjavor.d2g.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E16Omo1-000099-00@sites.inka.de>
Date: Thu, 10 Jan 2002 22:32:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020110205946.GB24838@zhadum.bjavor.d2g.com> you wrote:
> Can somebody please tell me what the above message means?

it means you run a root program which requested the network card to go into
promic mode. promisc mode means, the card will receive all packets on the
wire, not only those destinated to the card. a few sniffing/scan
detector/accounting apps require this, and some legal apps for network
configuration (like dhcp/bootp/... ) and arpwatch may require it.

Greetings
Bernd

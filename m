Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262747AbRFUFQq>; Thu, 21 Jun 2001 01:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264425AbRFUFQg>; Thu, 21 Jun 2001 01:16:36 -0400
Received: from quechua.inka.de ([212.227.14.2]:1035 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S262747AbRFUFQX>;
	Thu, 21 Jun 2001 01:16:23 -0400
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: how to display proxy arp addresses using "ip neigh" from iproute2
In-Reply-To: <3B2F6ADA.C2AD0304@nortelnetworks.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E15CwpL-0005ts-00@sites.inka.de>
Date: Thu, 21 Jun 2001 07:16:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B2F6ADA.C2AD0304@nortelnetworks.com> you wrote:
> 47.129.82.116     *       *                   MP            eth0

the asteriks simply show you, that the new linuix kernel will not be able to
remeber any mac address for a proxy arp entry. It will always respond with the
device' own MAC address. Can't find a way to display it with ip, "ip neigh
show nud all" will not show them, too.

Greetings
Bernd

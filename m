Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbUKXCBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUKXCBY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 21:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbUKXCBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 21:01:24 -0500
Received: from quechua.inka.de ([193.197.184.2]:36744 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261672AbUKXCBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 21:01:23 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Running Ethernet without ARP
Organization: Deban GNU/Linux Homesite
In-Reply-To: <41A3634D.6050108@rnl.ist.utl.pt>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CWmSy-0000C3-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 24 Nov 2004 03:01:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <41A3634D.6050108@rnl.ist.utl.pt> you wrote:
> or somehow a static table can be built.
> not sure what the point would be, but I cannot see anything that would make it impossible.

If it is a point to point link, you can also use the ethernet broadcast
target, or some multicast groups.

Greetings
Bernd

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbULFXxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbULFXxG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 18:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbULFXxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 18:53:06 -0500
Received: from quechua.inka.de ([193.197.184.2]:47770 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261700AbULFXxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 18:53:04 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20041206224107.GA8529@soohrt.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CbSf8-00047p-00@calista.eckenfels.6bone.ka-ip.net>
Date: Tue, 07 Dec 2004 00:53:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20041206224107.GA8529@soohrt.org> you wrote:
> Removing the iptables rules helps reducing the load a little, but the
> majority of time is still spent somewhere else.

In handling Interrupts. Are those equally sidtributed on eth0 and eth1?

Gruss
Bernd

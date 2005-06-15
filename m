Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVFOIWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVFOIWQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 04:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVFOIWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 04:22:16 -0400
Received: from quechua.inka.de ([193.197.184.2]:3782 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261306AbVFOIWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 04:22:15 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Why is one sync() not enough?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20050614215032.35d44e93.akpm@osdl.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DiT8f-00071G-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 15 Jun 2005 10:20:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050614215032.35d44e93.akpm@osdl.org> you wrote:
> What filesystem?  What kernel version?  Any unusual bind mounts, loopback
> mounts, etc?  There must be something there...

most likely unmount fils, or the ro-remount of root was not possible.

bernd

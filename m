Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbVKVIQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVKVIQl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 03:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbVKVIQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 03:16:41 -0500
Received: from quechua.inka.de ([193.197.184.2]:28564 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S964850AbVKVIQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 03:16:40 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <200511220115.17450.rob@landley.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1EeTKI-0004xu-00@calista.inka.de>
Date: Tue, 22 Nov 2005 09:16:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200511220115.17450.rob@landley.net> you wrote:
> 18 quintillion inodes are enough to give every ipv4 address on the internet 4 
> billion unique inodes.  I take it this is not enough space for Sun to work 
> out a reasonable allocation strategy in?

Yes, I think thats why they did it. However with ipv6, it bevomes 1-inode/node.

Gruss
Bernd

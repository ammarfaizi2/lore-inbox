Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267945AbUHaVsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267945AbUHaVsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267505AbUHaVrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:47:17 -0400
Received: from frog.mt.lv ([159.148.172.197]:39582 "EHLO frog.mt.lv")
	by vger.kernel.org with ESMTP id S267978AbUHaVpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:45:20 -0400
From: Dmitry Golubev <dmitry@mikrotik.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: 2.6.8.1, additional options for embedded systems
Date: Wed, 1 Sep 2004 00:44:29 +0300
User-Agent: KMail/1.6.2
References: <200408312255.40511.dmitry@mikrotik.com> <20040831142129.327d2dce.davem@davemloft.net>
In-Reply-To: <20040831142129.327d2dce.davem@davemloft.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409010044.29436.dmitry@mikrotik.com>
X-mikrotik.com-Virus_kerajs: Not scanned.
X-mikrotik.com-Virus_un_spam-kerajs: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Never used multicast?
>
> In fact, if I had to choose the place where multicast is most
> likely to be used it would be the desktop, and certainly not
> servers.

Honestly, never. Maybe in your country it is popular, but not in Latvia. 
Anyway, now we have another case of not needing multicasts ;)

Dmitry,
starting to think of how to make NFS without sunrpc and a kernel without UDP, 
ICMP and routing support...

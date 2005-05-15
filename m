Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVEORR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVEORR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 13:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVEORR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 13:17:28 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:9185 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261156AbVEORRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 13:17:10 -0400
Message-ID: <17923.195.126.66.126.1116177426.squirrel@housecafe.dyndns.org>
In-Reply-To: <1116116799.14297.29.camel@lade.trondhjem.org>
References: <428691E3.9040800@g-house.de>
    <1116116799.14297.29.camel@lade.trondhjem.org>
Date: Sun, 15 May 2005 19:17:06 +0200 (CEST)
Subject: Re: probably NFS related Oops during shutdown with 2.6.12-rc3-mm3
From: "Christian" <evil@g-house.de>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Trond Myklebust" <trond.myklebust@fys.uio.no>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 2:26, Trond Myklebust said:
>
> That should already have been fixed in 2.6.12-rc4-mm1.
>

minutes after sending the report, i saw that 2.6.12-rc4-mm1 was out
already. compiled, booted, but today's shutdown produced the same error
:-(

just in case i was unclear: the shutdown completes, the oops shows "only"
up on the tty, no data corruption or the like so far.

are there any fancy debug flags i could set, to provide more information?

thank,
Christian.

-- 
make bzImage, not war


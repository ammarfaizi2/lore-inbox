Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTFPC7E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 22:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTFPC7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 22:59:04 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39429 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263295AbTFPC7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 22:59:02 -0400
Date: Sun, 15 Jun 2003 23:06:11 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Christoph Hellwig <hch@lst.de>
cc: support@comtrol.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] License issue with rocket driver
In-Reply-To: <20030606094759.GA20229@lst.de>
Message-ID: <Pine.LNX.3.96.1030615230303.22624A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jun 2003, Christoph Hellwig wrote:

> drivers/char/rocket{,_int}.h have an intereesting and gpl-incompatible
> license.  Could you please fix it or remove the drier from the tree?
> (given that mess that this driver is the latter might be the better
> idea..)
> 
> The license is:
> 
>  * The following source code is subject to Comtrol Corporation's
>  * Developer's License Agreement.
>  * 
>  * This source code is protected by United States copyright law and 
>  * international copyright treaties.
>  * 
>  * This source code may only be used to develop software products
>  * international copyright treaties.
>  * 
>  * This source code may only be used to develop software products that
>  * will operate with Comtrol brand hardware.
>  * 
>  * You may not reproduce nor distribute this source code in its original
>  * form but must produce a derivative work which includes portions of
>  * this source code only.
>  * 
>  * The portions of this source code which you use in your derivative
>  * work must bear Comtrol's copyright notice:
>  * 
>  *              Copyright 1994 Comtrol Corporation.

I don't see that it would disagree with GPL, let's try to get the existing
Linux driver GPL'd with their agreement. I don't see that it helps anyone
to just start throwing out drivers without at least checking with the
author on license terms.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266085AbUFWC7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbUFWC7K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 22:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266086AbUFWC7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 22:59:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9654 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266085AbUFWC7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 22:59:07 -0400
Message-ID: <40D8F1EE.4080106@pobox.com>
Date: Tue, 22 Jun 2004 22:58:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: syphir@syphir.sytes.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops introduced in kernel-2.6.7-bk4+
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAMg8EaGipjkWalR4FA3PwJwEAAAAA@syphir.sytes.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAMg8EaGipjkWalR4FA3PwJwEAAAAA@syphir.sytes.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C.Y.M. wrote:
> After installing kernel-2.6.7-bk4 and bk5, my machine fails to start (with
> an Oops) right about when Samba attempts to load from the init.d script.
> Kernel-2.6.7-bk3 works perfectly, so it must be something that was changed
> right about on June 20th.
[...]
> P.S. I would have included the actual Oops message in this email but it was
> not in any of the logs.  The error is occuring before the machine can get
> started.


This doesn't help us a while lot :(

See if you can copy the oops by hand, or use a serial console to copy it 
onto another computer.

	Jeff



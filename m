Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283637AbRLDOod>; Tue, 4 Dec 2001 09:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283655AbRLDOm6>; Tue, 4 Dec 2001 09:42:58 -0500
Received: from apollo.sot.fi ([195.74.13.237]:263 "HELO vscan.sot.com")
	by vger.kernel.org with SMTP id <S283713AbRLDOER>;
	Tue, 4 Dec 2001 09:04:17 -0500
Date: Tue, 4 Dec 2001 16:04:14 +0200 (EET)
From: Yaroslav Popovitch <yp@sot.com>
To: Erik Tews <erik.tews@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange messages with 2.4.16
In-Reply-To: <20011203233612.J11967@no-maam.dyndns.org>
Message-ID: <Pine.LNX.4.10.10112041603270.4880-100000@ares.sot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I see the  same msgs in 2.4.12

On Mon, 3 Dec 2001, Erik Tews wrote:

> Hi
> 
> After having bootet 2.4.16 vanilla on an dual piii-system, I saw the
> following messages:
> 
> invalidate: busy buffer
> invalidate: busy buffer
> invalidate: busy buffer
> 
> They appear during the execution of vgscan. The same kernel on an other
> machine with the same version of userland-utilities for lvm but other
> hardware doesn't show anyone of these messages. What do they want to
> tell me? Has anybody else seen this messages?
> 
> I can give you an detailed report about the hardware I am seeing this
> messages on if intrested.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


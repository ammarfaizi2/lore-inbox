Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265586AbUBAVTF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265573AbUBAVTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:19:05 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:3817 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S265586AbUBAVRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:17:20 -0500
Date: Sun, 1 Feb 2004 23:16:56 +0200 (EET)
From: =?iso-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>
X-X-Sender: midian@midi
To: Christian Borntraeger <kernel@borntraeger.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Uptime counter
In-Reply-To: <200402012202.07204.kernel@borntraeger.net>
Message-ID: <Pine.LNX.4.44.0402012314310.6574-100000@midi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Feb 2004, Christian Borntraeger wrote:
>
> In 2.6 there is no 497 days limit, as jiffies are now 64 bit.
>
Ok, I just would be intrested in a patch for 2.0 and 2.4 to get these
jiffies to 64 bit.
> By the way: Having a machine with more than 497 days of uptime normally
> shows a serios lack of security awareness..
>
I know, but running a 2.0.x machine with that kind of uptime isn't really
that bad, thought if the machine has alot of accounts it wouldn't be that
great idea.

But anyway, thanks for the information!

	Markus


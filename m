Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbTIHRpc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 13:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbTIHRpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 13:45:32 -0400
Received: from chaos.analogic.com ([204.178.40.224]:27268 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263449AbTIHRpb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 13:45:31 -0400
Date: Mon, 8 Sep 2003 13:48:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@suse.cz>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Some read-errors on floppys not reported on 2.4.22
In-Reply-To: <20030904171758.GR1358@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.53.0309081346390.1682@chaos>
References: <Pine.LNX.4.53.0308291207430.25423@chaos> <20030904171758.GR1358@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Pavel Machek wrote:

> Hi!
>
> > Success, even where there are lots of CRC errors that
> > prematurely terminate the read:
>
> Can you find out if it works in 2.4.21?
> --
> 				Pavel
> Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...
>

I will try and get back to you. I was not able to even boot
2.4.21 on my system because there were problems with aic7xxx
SCSI disk controller so I gave up. I will mix/match and see
what I can find.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271755AbTHHTDV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 15:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271811AbTHHTBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 15:01:25 -0400
Received: from chaos.analogic.com ([204.178.40.224]:22400 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S271807AbTHHSzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:55:20 -0400
Date: Fri, 8 Aug 2003 14:56:11 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Michael Frank <mflt1@micrologica.com.hk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question - why is dmesg interleaved with rc.sysinit logs
 in messages?
In-Reply-To: <200308090229.26494.mflt1@micrologica.com.hk>
Message-ID: <Pine.LNX.4.53.0308081453110.1760@chaos>
References: <200308090229.26494.mflt1@micrologica.com.hk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003, Michael Frank wrote:

> Why is this and how to fix?
>
[SNIPPED...]

Fix?
`man initlog`
`less /etc/rc.d/rc.sysinit`

RH 9 does this, not the kernel.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


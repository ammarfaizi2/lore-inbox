Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbUKGKZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbUKGKZn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 05:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbUKGKZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 05:25:42 -0500
Received: from smtpout.mac.com ([17.250.248.85]:61657 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261572AbUKGKZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 05:25:38 -0500
In-Reply-To: <aad1205e0411062306690c21f8@mail.gmail.com>
References: <aad1205e0411062306690c21f8@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <595C7524-30A7-11D9-8C52-000D9352858E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: [PATCH]tar filesystem for 2.6.10-rc1-mm3(easily access tar file)
Date: Sun, 7 Nov 2004 11:25:30 +0100
To: andyliu <liudeyan@gmail.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 7, 2004, at 08:06, andyliu wrote:

>   but with the help of the tarfs,we can mount a tar file to some dir 
> and access
> it easily and quickly.it's like the tarfs in mc.
>
>  just mount -t tarfs tarfile.tar /dir/to/mnt -o loop
> then access the files easily.

Simply wonderful!


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWAVPuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWAVPuu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 10:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWAVPuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 10:50:50 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:42985 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751252AbWAVPut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 10:50:49 -0500
Message-ID: <43D3A9D1.2060800@cfl.rr.com>
Date: Sun, 22 Jan 2006 10:50:41 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shaun Savage <savages@tvlinux.org>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: CBD Compressed Block Device, New embedded block device
References: <43D3467C.7010803@tvlinux.org>
In-Reply-To: <43D3467C.7010803@tvlinux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How is this different from cloop or dm-crypt?

Shaun Savage wrote:
> HI
> 
> Here is a patch for 2.6.14.5 of CBD
> CBD is a compressed block device that is designed to shrink the file 
> system size to 1/3 the original size.  CBD is a block device on a file 
> system so, it also allows for in-field upgrade of file system.  If 
> necessary is also allows for secure booting, with a GRUB patch.
> 
> Reply to email please.
> 
> Shaun Savage

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269276AbUISRDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269276AbUISRDk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 13:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269277AbUISRDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 13:03:39 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:4100 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S269276AbUISRDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 13:03:36 -0400
In-Reply-To: <200409191214.47206.norberto+linux-kernel@bensa.ath.cx>
References: <200409191214.47206.norberto+linux-kernel@bensa.ath.cx>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D36064A5-0A5D-11D9-96E1-000D9352858E@linuxmail.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: Is anyone using vmware 4.5 with 2.6.9-rc2-mm1?
Date: Sun, 19 Sep 2004 19:03:27 +0200
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 19, 2004, at 17:14, Norberto Bensa wrote:

> Hello list,
>
> This is what vmware is saying:
>
>     "Could not mmap 139264 bytes of memory from file offset 0 at (nil):
>     Operation not permitted. Failed to allocate shared memory."
>
>
> Vmware works fine with 2.6.9-rc1-mm5.

It's woking fine for me... I'm using VMwareWorkstation-4.5.2-8848 
running on top of kernel-2.6.9-rc2-mm1-VP-S1 and Fedora Core RawHide 
with no apparent problems (i.e. dmesg shows no errors) and total 
functionality.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWCGD7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWCGD7i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 22:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbWCGD7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 22:59:38 -0500
Received: from xenotime.net ([66.160.160.81]:7598 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751080AbWCGD7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 22:59:38 -0500
Date: Mon, 6 Mar 2006 20:01:11 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Reg Clemens <reg@dwf.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: vmlinuz-2.6.16-rc5-git8 still nogo with Intel D945 Motherboard
Message-Id: <20060306200111.6b6e808d.rdunlap@xenotime.net>
In-Reply-To: <200603070340.k273ev0A003594@deneb.dwf.com>
References: <200603070340.k273ev0A003594@deneb.dwf.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Mar 2006 20:40:57 -0700 Reg Clemens wrote:

> Im still running a 2.6.11 
> Ever since some PCI changes (between 2.6.11 and 2.6.15) I have been
> unable to build a kernel that will run with my machine on an 
> Intel D945 Motherboard.
> 
> I just tried vmlinuz-2.6.16-rc5-git8 and still no luck, the kernel builds,
> but during the first few lines of the boot you get the message:
> 
>     PCI: Failed to allocate mem resource #6 ...
> 
> Ive tried stripping things down to just the video card, and still the same
> result.
> 
> This Motherboard has been available for the better part of a year, and
> still no Linux support.  Usually by the time I buy something, its supported.
> 
> Anyone working this problem?

Mine works, but I expect that we don't have the same video card.
Mine is intel integrated video.
So like Lee said, we need more info.

---
~Randy

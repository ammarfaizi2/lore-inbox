Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVAWPoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVAWPoX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 10:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVAWPoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 10:44:23 -0500
Received: from innocence.nightwish.hu ([217.20.130.196]:2222 "EHLO
	innocence.nightwish.hu") by vger.kernel.org with ESMTP
	id S261316AbVAWPoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 10:44:20 -0500
Subject: Re: the famous Tyan S2885 PCI IDE problem, additional experiences
	[resolved]
From: Pallai Roland <dap@mail.index.hu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1105913658.3155.56.camel@localhost.localdomain>
References: <1105913658.3155.56.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 23 Jan 2005 16:44:13 +0100
Message-Id: <1106495054.3155.147.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I've upgraded from 2.6.9 to 2.6.11-rc1 and the problem has been gone!


On Sun, 2005-01-16 at 23:14 +0100, Pallai Roland wrote:
>  I've read a thread about Tyan S2885 IDE problems
> (http://www.ussg.iu.edu/hypermail/linux/kernel/0412.3/0457.html),
> unfortunately I suffered from it too, but in a different hardware setup
> and I noticed some more details about it, I hope this may help somehow.
> 
>  My config is a Tyan Thunder K8W (S2885) dual Operon244 with 5 HighPoint
> 1820 PCI-X sata controllers and 44/4 SATA/UATA drives, and I get daily
> 2-3 messages like this, sometimes followed by a lockup:
> 
> Jan 12 09:16:45 EverDream kernel: IAL: COMPLETION ERROR, adapter 2, channel 5, flags=101
> Jan 12 09:16:45 EverDream kernel: Retry on channel(5)
> Jan 12 11:05:52 EverDream kernel: IAL: COMPLETION ERROR, adapter 1, channel 7, flags=101
> Jan 12 11:05:52 EverDream kernel: IAL: COMPLETION ERROR, adapter 2, channel 7, flags=101
> Jan 12 11:05:52 EverDream kernel: Retry on channel(7)
> Jan 12 11:05:52 EverDream kernel: Retry on channel(7)


--
 dap


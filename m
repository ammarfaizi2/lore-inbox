Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752000AbWHNL4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbWHNL4H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbWHNL4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:56:07 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:12496 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1752013AbWHNL4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:56:06 -0400
Date: Mon, 14 Aug 2006 13:55:45 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HT not active
In-Reply-To: <6bffcb0e0608140446i9508a27y75c234721e3e70d0@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0608141355060.16548@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0608141335550.7970@yvahk01.tjqt.qr>
 <6bffcb0e0608140446i9508a27y75c234721e3e70d0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> What could be missing? Some BIOS option perhaps?
>> Thanks for any hints.
>
> Do you have CONFIG_NR_CPUS=2 in kernel config?

CONFIG_NR_CPUS=32
http://jengelh.hopto.org/w04a.gz


Jan Engelhardt
-- 

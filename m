Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVLKNzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVLKNzx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 08:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbVLKNzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 08:55:53 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:49049 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750703AbVLKNzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 08:55:53 -0500
Date: Sun, 11 Dec 2005 14:55:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.14-rt20, fixed compiled bug
Message-ID: <20051211135510.GE30475@elte.hu>
References: <ff1cadb20511271539n13ba2da1o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff1cadb20511271539n13ba2da1o@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Luca Falavigna <dktrkranz@gmail.com> wrote:

> This patch, compiled against 2.6.14-rt20, fixes a couple of compile 
> bugs involving files include/i386/io_apic.h and 
> include/x86_64/io_apic.h

thanks, applied.

	Ingo

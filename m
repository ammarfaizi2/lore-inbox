Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUHXLMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUHXLMh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 07:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267482AbUHXLMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 07:12:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60896 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265127AbUHXLMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 07:12:34 -0400
Date: Mon, 23 Aug 2004 21:51:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Brunet <Eric.Brunet@lps.ens.fr>
Cc: Paul Gortmaker <p_gortmaker@yahoo.com>, arekm@pld-linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH swsuspend for ne2k-pci cards
Message-ID: <20040823195149.GB3013@openzaurus.ucw.cz>
References: <20040806235438.GA7095@lps.ens.fr> <20040807071346.91641.qmail@web60510.mail.yahoo.com> <20040807140845.GA8353@lps.ens.fr> <20040821121430.GB8826@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821121430.GB8826@lps.ens.fr>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Arkadiusz Miskiewicz had some suggestions to improve my patch which
> adds suspend/resume support to ne2k-pci.c. Actually, he basically rewrote
> it.
> 
> This patch was only tested on my own ne2k clone [Realtek Semiconductor
> Co., Ltd. RTL-8029(AS)], and it works nicely for me. As 1) it cannot hurt
> people which are not using swsuspend 2) it can only improve things for
> people using swsuspend, it would be nice if this patch could go into the
> kernel.

Patch looks good to me...

				Pavel


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


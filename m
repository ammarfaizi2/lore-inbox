Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266953AbSKLUzN>; Tue, 12 Nov 2002 15:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266955AbSKLUzN>; Tue, 12 Nov 2002 15:55:13 -0500
Received: from 213-96-224-204.uc.nombres.ttd.es ([213.96.224.204]:23562 "EHLO
	betawl.net") by vger.kernel.org with ESMTP id <S266953AbSKLUzM>;
	Tue, 12 Nov 2002 15:55:12 -0500
Date: Tue, 12 Nov 2002 22:01:56 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: David Meybohm <dmeybohm@bellsouth.net>
Cc: linux-kernel@vger.kernel.org, Santiago Garcia Mantinan <manty@manty.net>,
       Ted Kaminski <mouschi@wi.rr.com>
Subject: Re: [PATCH] Fix SB16 PnP IDE controller in 2.4
Message-ID: <20021112210156.GA4375@man.beta.es>
References: <20021108061020.A14168@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108061020.A14168@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch fixes the SB16 PnP IDE controller in 2.4 and is
> against 2.4.20-rc1.

I have applied it again, now on 2.4.20-rc1 and it seems to work ok here, I
had the two cards tested in different orders, no problems. The machine is a
Dual Pentium with SMP enabled in case that matters.

I think it would be good to have this patch on 2.4.20, but if it is too late
for that, then please consider it for 2.4.21.

Regards...
-- 
Manty/BestiaTester -> http://manty.net

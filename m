Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281360AbRLWMgT>; Sun, 23 Dec 2001 07:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286885AbRLWMgK>; Sun, 23 Dec 2001 07:36:10 -0500
Received: from uucp.gnuu.de ([151.189.0.84]:24838 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id <S286883AbRLWMgE>;
	Sun, 23 Dec 2001 07:36:04 -0500
Date: Sun, 23 Dec 2001 13:33:20 +0100
From: Stefan Frank <sfr@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17rc1: KERNEL: assertion failed at tcp.c(1520):tcp_recvmsg ?
Message-ID: <20011223123320.GA1034@obelix.gallien.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011222083457.GA666@asterix> <20011222.155713.84363957.davem@redhat.com> <20011223112953.GA7856@obelix.gallien.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011223112953.GA7856@obelix.gallien.de>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

ok, here's a followup on my own mail. I just replaced 
all the memory with the one from my workstation (256MB + 128MB)
and htdig's cron job still locks up the machine, so although
the 512MB module might have a bit-error it's NOT the cause of the 
problem here. My workstation is running about a year now with this
memory and NEVER locked up like this. 

So IMHO the problem lies somewhere else. 

Any suggestions? I'm happy to provide more information if it helps.

TIA for your effort!

    Bye, Stefan

PS: the filesystems are all ext3, in case it matters

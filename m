Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUIGKnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUIGKnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 06:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267520AbUIGKnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 06:43:25 -0400
Received: from the-village.bc.nu ([81.2.110.252]:55204 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265207AbUIGKnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 06:43:24 -0400
Subject: Re: [BUG] r200 dri driver deadlocks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Patrick McFarland <diablod3@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <d577e5690409070207448961a4@mail.gmail.com>
References: <d577e569040904021631344d2e@mail.gmail.com>
	 <1094321696.31459.103.camel@admin.tel.thor.asgaard.local>
	 <d577e56904090413365f5e223d@mail.gmail.com>
	 <1094366099.31457.112.camel@admin.tel.thor.asgaard.local>
	 <d577e56904090501224f252dbc@mail.gmail.com>
	 <1094406055.31464.118.camel@admin.tel.thor.asgaard.local>
	 <d577e569040905131870fa14a3@mail.gmail.com>
	 <1094429682.29921.6.camel@krustophenia.net>
	 <d577e569040906040147c2277f@mail.gmail.com>
	 <1094494329.31464.187.camel@admin.tel.thor.asgaard.local>
	 <d577e5690409070207448961a4@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094550056.9152.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 10:41:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-07 at 10:07, Patrick McFarland wrote:
> Also, what happens to r200 users who happen to use Debian? Using dri
> cvs snapshots

If Debian is currently shipping a buggy driver then Debian needs to ship
a working driver. Same as anyone else. You'll also need the newest
dri driver for Radeon IGP (most ATI chipset laptops) and the newer
R2xx hardware.

Alan


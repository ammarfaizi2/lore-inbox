Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSI0BNj>; Thu, 26 Sep 2002 21:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261595AbSI0BNj>; Thu, 26 Sep 2002 21:13:39 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:29452 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S261594AbSI0BNi>; Thu, 26 Sep 2002 21:13:38 -0400
Date: Thu, 26 Sep 2002 21:18:04 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: twaugh@redhat.com, <serial24@macrolink.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] fix parport_serial / serial link order (for 2.4.20-pre8)
In-Reply-To: <E17uesu-0002dE-00@mm.lan.amelek.gda.pl>
Message-ID: <Pine.LNX.4.44.0209262116550.1632-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Marek Michalkiewicz wrote:

> I need this for NM9835 support (working fine here on two machines) -
> I'd like to submit a separate patch for this (so the parport_serial.c
> NM9835-related changes are easy to see, after the file is moved to
> the new place).  Please let me know if you see any problems with
> this patch - it certainly looks like a bug fix to me...

Ahh return of the 9835 =) This POS never goes away...

	Zwane

--
function.linuxpower.ca



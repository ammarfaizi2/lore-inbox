Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132603AbRDAXu0>; Sun, 1 Apr 2001 19:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132600AbRDAXuR>; Sun, 1 Apr 2001 19:50:17 -0400
Received: from hyperion.expio.net.nz ([202.27.199.10]:42501 "EHLO expio.co.nz")
	by vger.kernel.org with ESMTP id <S132599AbRDAXt7>;
	Sun, 1 Apr 2001 19:49:59 -0400
Message-ID: <011f01c0bb06$8b789fb0$1400a8c0@expio.net.nz>
From: "Simon Garner" <sgarner@expio.co.nz>
To: <linux-kernel@vger.kernel.org>, <linux-smp@vger.kernel.org>
In-Reply-To: <1168.986129490@ocs3.ocs-net>
Subject: Re: Asus CUV4X-D, 2.4.3 crashes at boot 
Date: Mon, 2 Apr 2001 11:49:30 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Keith Owens" <kaos@ocs.com.au>

> >Doesn't matter. The NMI-watchdog tries to detect SMP-lockups, and is
> >always present. Unless you specifically disable it on boot.
>
> Not any more.  In 2.4.3-ac* the default is no watchdog and it must be
> specifically enabled at boot.
>


nmi_watchdog 0 didn't help - the above would explain why.

Any more ideas? My expensive server is basically useless because of this. :(


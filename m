Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281678AbRLQR0G>; Mon, 17 Dec 2001 12:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281719AbRLQRZ4>; Mon, 17 Dec 2001 12:25:56 -0500
Received: from ns.suse.de ([213.95.15.193]:50436 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281678AbRLQRZs> convert rfc822-to-8bit;
	Mon, 17 Dec 2001 12:25:48 -0500
Date: Mon, 17 Dec 2001 18:25:37 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: =?ISO-8859-1?Q?Sebastian_Dr=F6ge?= <sebastian.droege@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <20011217182343.7aea2048.sebastian.droege@gmx.de>
Message-ID: <Pine.LNX.4.33.0112171822250.28670-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Sebastian Dröge wrote:

> Thanks
> This does work

Great, now can you edit the patch to remove the ioapic.c hunk,
reapply, and see if that works..

> What do you think was exactly the problem?

looks like I dorked the apic init...
I'll back that bit out for -dj2, until I've given
it a bit more work.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs


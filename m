Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQKQOha>; Fri, 17 Nov 2000 09:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129440AbQKQOhK>; Fri, 17 Nov 2000 09:37:10 -0500
Received: from 62-6-229-118.btconnect.com ([62.6.229.118]:36491 "EHLO
	saturn.homenet") by vger.kernel.org with ESMTP id <S129410AbQKQOhH>;
	Fri, 17 Nov 2000 09:37:07 -0500
Date: Fri, 17 Nov 2000 14:02:29 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Andi Kleen <ak@suse.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Christoph Rohland <cr@sap.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikael Pettersson <mikpe@csd.uu.se>, Jordan <ledzep37@home.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error in x86 CPU capabilities starting with test5/6
In-Reply-To: <20001117145436.A7555@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0011171400550.8383-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Andi Kleen wrote:
> [of course rdtsc only works properly on UP or with bind_cpu()]

I thought Linux kernel does synchronize them on boot? So, you are saying I
cannot rely on this being 100% correct?

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274177AbRJDPWe>; Thu, 4 Oct 2001 11:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274171AbRJDPWY>; Thu, 4 Oct 2001 11:22:24 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:3091
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S274177AbRJDPWR>; Thu, 4 Oct 2001 11:22:17 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200110041503.f94F3RK12908@www.hockin.org>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
To: hadi@cyberus.ca (jamal)
Date: Thu, 4 Oct 2001 08:03:27 -0700 (PDT)
Cc: sim@netnation.com (Simon Kirby), greearb@candelatech.com (Ben Greear),
        mingo@elte.hu (Ingo Molnar), linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru (Alexey Kuznetsov),
        Robert.Olsson@data.slu.se (Robert Olsson),
        bcrl@redhat.com (Benjamin LaHaise), netdev@oss.sgi.com,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.GSO.4.30.0110040751040.9341-100000@shell.cyberus.ca> from "jamal" at Oct 04, 2001 07:54:19 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Has nothing to do with specific hardware although i see your point.
> send me an eepro and i'll at least add hardware flow control for you.
> The API is simple, its up to the driver maintainers to use. This
> discussion is good to make people aware of those drivers.


is there a place where this is explained?  I'd be happy to make drivers on
which I work support this.  It's like ethtool - easy to do, but no one has
done it because they didn't know.


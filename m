Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284374AbRLEMxt>; Wed, 5 Dec 2001 07:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284365AbRLEMxk>; Wed, 5 Dec 2001 07:53:40 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:6063 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284363AbRLEMx3>; Wed, 5 Dec 2001 07:53:29 -0500
Date: Wed, 5 Dec 2001 14:57:19 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: APIC Error when doing apic_pm_suspend
In-Reply-To: <3C0DF24C.1B128C80@redhat.com>
Message-ID: <Pine.LNX.4.33.0112051455420.26065-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Arjan van de Ven wrote:
> Just about all bioses that support suspend do not have the knowledge
> that an
> operating system would use apics, since windows95 doesn't do that. The
> fact
> that it appears to mostly work for you is RARE. You're very very lucky
> with
> an almost not broken bios..... UP APIC and Suspend are usually very
> exclusive.
> (well, actually, the suspend often works, it's the resume that hurts)

Hmm that puts things in a different light... don't you just the love PC
compatible ;)

Thanks,
	Zwane Mwaikambo



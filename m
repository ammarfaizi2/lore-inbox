Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131640AbRCQN4l>; Sat, 17 Mar 2001 08:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbRCQN4c>; Sat, 17 Mar 2001 08:56:32 -0500
Received: from netsonic.fi ([194.29.192.20]:45327 "EHLO nalle.netsonic.fi")
	by vger.kernel.org with ESMTP id <S131630AbRCQN4R>;
	Sat, 17 Mar 2001 08:56:17 -0500
Date: Sat, 17 Mar 2001 15:55:20 +0200 (EET)
From: Sampsa Ranta <sampsa@netsonic.fi>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <Werner.Almesberger@epfl.ch>, <linux-net@vger.kernel.org>,
        <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: Performance is weird (fwd) -> results
In-Reply-To: <3AB2300E.33268BBC@colorfullife.com>
Message-ID: <Pine.LNX.4.33.0103171547450.15277-100000@nalle.netsonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2001, Manfred Spraul wrote:

> Sampsa Ranta wrote:
> >
> > After either of your patches, the result was the same, sorry.
> >
> Is apm or acpi running?

No, I tried both SMP and non-SMP version of kernel, the machine is however
single processor Athlon 900. CONFIG_ACPI is not set, CONFIG_APM is not
set. The 2.4.3pre4 still performs 66M/s without "the load" and 124M/s+
with  load. However there is much different between 2.4.2 and 2.4.3pre
about 33M/s to 66M/s.

 - Sampsa Ranta
   sampsa@netsonic.fi


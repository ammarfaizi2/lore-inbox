Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283055AbRK1OHu>; Wed, 28 Nov 2001 09:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283054AbRK1OHn>; Wed, 28 Nov 2001 09:07:43 -0500
Received: from chaos.analogic.com ([204.178.40.224]:60556 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S282149AbRK1OHa>; Wed, 28 Nov 2001 09:07:30 -0500
Date: Wed, 28 Nov 2001 09:07:26 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Lars Brinkhoff <lars@nocrew.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Magic Lantern
In-Reply-To: <85adx7vw12.fsf@junk.nocrew.org>
Message-ID: <Pine.LNX.3.95.1011128090654.10732B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Nov 2001, Lars Brinkhoff wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> > Are there currently any kernel hooks to support Magic Lantern?
> > Basically, a "tee" to capture all network packets and pass them
> > on to a filtering task without affecting normal network activity.
> > It's like `tcpdump`, but allows packets to be inserted into the
> > output queue as well without affecting normal network activity.
> 
> The af_packet module can read and write raw ethernet frames.

Okay, thanks.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.



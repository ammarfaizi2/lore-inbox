Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280095AbRKNEiQ>; Tue, 13 Nov 2001 23:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280096AbRKNEiF>; Tue, 13 Nov 2001 23:38:05 -0500
Received: from symphony-03.iinet.net.au ([203.59.3.35]:45584 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S280095AbRKNEhz>;
	Tue, 13 Nov 2001 23:37:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Harvey <matlhdam@iinet.net.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.14 fails to boot on a MediaGX
Date: Wed, 14 Nov 2001 12:32:53 +0800
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E163mzs-0002k2-00@the-village.bc.nu>
In-Reply-To: <E163mzs-0002k2-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01111412325302.00696@blackbox.local>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2001 07:29, Alan Cox wrote:
> > I've compiled 2.4.14 on a MediaGX running at 133 MHz that I use for a
> > gateway, and am having some difficulty getting it to boot. The last three
> > lines of output are as follows:
>
> What processor did you compile for.

Compiled for 486. I remember reading that 586 optimisations (used to?) break 
the kernel on MediaGXs.

>
> > Working around Cyrix MediaGX virtual DMA bugs.
> > CPU: Cyrix MediaGX 3x Core/Bus Clock
> > Checking 'hlt' instruction... OK.
>
> 2.4.12-ac was working on my 233Mhz MediaGX. I suspect 2.4.14 does too. I'll
> give it a test tho

Thanks for the help.

Adam

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129215AbQKBTTG>; Thu, 2 Nov 2000 14:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129247AbQKBTS4>; Thu, 2 Nov 2000 14:18:56 -0500
Received: from Cantor.suse.de ([194.112.123.193]:23819 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129215AbQKBTSn>;
	Thu, 2 Nov 2000 14:18:43 -0500
Date: Thu, 2 Nov 2000 20:18:36 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tim Riker <Tim@Rikers.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
Message-ID: <20001102201836.A14409@gruyere.muc.suse.de>
In-Reply-To: <3A01B8BB.A17FE178@Rikers.org> <E13rPhi-0001ng-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13rPhi-0001ng-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Nov 02, 2000 at 07:07:12PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 07:07:12PM +0000, Alan Cox wrote:
> > 1. There are architectures where some other compiler may do better
> > optimizations than gcc. I will cite some examples here, no need to argue
> 
> I think we only care about this when they become free software.

SGI's pro64 is free software and AFAIK is able to compile a kernel on IA64.
It is also not clear if gcc will ever produce good code on IA64.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270758AbRHNTex>; Tue, 14 Aug 2001 15:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270766AbRHNTen>; Tue, 14 Aug 2001 15:34:43 -0400
Received: from ns.suse.de ([213.95.15.193]:8712 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S270758AbRHNTe3>;
	Tue, 14 Aug 2001 15:34:29 -0400
Date: Tue, 14 Aug 2001 21:34:42 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Ignacio Vazquez-Abrams <ignacio@openservices.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: memory compress tech...
In-Reply-To: <Pine.LNX.4.33.0108141242160.31226-100000@terbidium.openservices.net>
Message-ID: <Pine.LNX.4.30.0108142134090.5059-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001, Ignacio Vazquez-Abrams wrote:

> > maybe for compressing swap?  you have to read less data off the disk,
> > which is faster.  and the processor is probably idling anyway, waiting on
> > disk.
> Ah, now THAT is a good idea.

I missed the beginning of this thread, but this sounds to me like
what is being implemented at http://linuxcompressed.sourceforge.net/

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs


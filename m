Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280288AbRKBP5l>; Fri, 2 Nov 2001 10:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280299AbRKBP5b>; Fri, 2 Nov 2001 10:57:31 -0500
Received: from grobbebol.xs4all.nl ([194.109.248.218]:61278 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280288AbRKBP5Y>; Fri, 2 Nov 2001 10:57:24 -0500
Date: Fri, 2 Nov 2001 15:56:20 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Ken Brownfield <brownfld@irridia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO APIC (smp) / crashes ?
Message-ID: <20011102155620.A31283@grobbebol.xs4all.nl>
In-Reply-To: <20011030124037.A26140@grobbebol.xs4all.nl> <20011031084940.C31431@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20011031084940.C31431@asooo.flowerfire.com>; from brownfld@irridia.com on Wed, Oct 31, 2001 at 08:49:40AM -0600
X-OS: Linux grobbebol 2.4.13 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 08:49:40AM -0600, Ken Brownfield wrote:
> I've been using this patch in production for a bit, and it seems to
> avoid the problem inobtrusively... without actually solving the problem
> correctly. :(  The APIC code is daunting, not to mention that it
> requires 12 hours or so of a particular type and weight of load to
> trigger the issue, so debugging it with my lack of APIC-fu is a
> frightening concept.
> 
> BTW, if anyone with more APIC-fu than I would perhaps know _why_ this
> patch works around the issue that I think Roeland is explaining and the
> issue I've mentioned here in the past, please holler.
> 
> Let me know how it goes,


ok, I compiled the kernel and will test it for a while. will let you
know. the good path is that I now also have ext3 -- makes the crash more
bearable :-)

-- 
Grobbebol's Home                      |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel          | Use your real e-mail address   /\
Linux 2.4.13 (apic) SMP 466MHz/768 MB |        on Usenet.             _\_v  

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129247AbQKBTXh>; Thu, 2 Nov 2000 14:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129376AbQKBTX1>; Thu, 2 Nov 2000 14:23:27 -0500
Received: from ra.lineo.com ([204.246.147.10]:6051 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S129247AbQKBTXR>;
	Thu, 2 Nov 2000 14:23:17 -0500
Message-ID: <3A01BDCD.FCBCFFF8@Rikers.org>
Date: Thu, 02 Nov 2000 12:17:33 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
In-Reply-To: <3A01B8BB.A17FE178@Rikers.org> <E13rPhi-0001ng-00@the-village.bc.nu> <20001102201836.A14409@gruyere.muc.suse.de>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 11/02/2000
 12:23:13 PM,
	Serialize complete at 11/02/2000 12:23:13 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Thu, Nov 02, 2000 at 07:07:12PM +0000, Alan Cox wrote:
> > > 1. There are architectures where some other compiler may do better
> > > optimizations than gcc. I will cite some examples here, no need to argue
> >
> > I think we only care about this when they become free software.
> 
> SGI's pro64 is free software and AFAIK is able to compile a kernel on IA64.
> It is also not clear if gcc will ever produce good code on IA64.
> 
> -Andi

A grand example I should have included. Thanx! Last I knew the status
was that SGI had built the kernel with thier compiler, by adding gcc
syntax into it, but had not reached the point where the kernel would
run. Perhaps they have gotten past this. Since I'm no longer involved in
the Trillian (read ia64 Linux Project) mailing lists or weekly phone
calls I have been out of this loop for a month or so.
-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

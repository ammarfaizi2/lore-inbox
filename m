Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280035AbRKDXNJ>; Sun, 4 Nov 2001 18:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280032AbRKDXM7>; Sun, 4 Nov 2001 18:12:59 -0500
Received: from grobbebol.xs4all.nl ([194.109.248.218]:9845 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S279968AbRKDXMs>; Sun, 4 Nov 2001 18:12:48 -0500
Date: Sun, 4 Nov 2001 23:11:55 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Ken Brownfield <brownfld@irridia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO APIC (smp) / crashes ?
Message-ID: <20011104231155.A11186@grobbebol.xs4all.nl>
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
> Ah yes, I've seen this behavior since 2.4.0-test1 (didn't play with
> 2.3).  Assuming this is the problem I think it is...

Ken,

I tried your patch, it helps the box -- keeps alive for approx 8 hours
when streaming instead of a few minutes to a few hours.

still it's being killed. 

-- 
Grobbebol's Home                      |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel          | Use your real e-mail address   /\
Linux 2.4.13 (apic) SMP 466MHz/768 MB |        on Usenet.             _\_v  

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129582AbQKHUTm>; Wed, 8 Nov 2000 15:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129640AbQKHUTd>; Wed, 8 Nov 2000 15:19:33 -0500
Received: from mirrors.planetinternet.be ([194.119.238.163]:28937 "EHLO
	mirrors.planetinternet.be") by vger.kernel.org with ESMTP
	id <S129582AbQKHUTU>; Wed, 8 Nov 2000 15:19:20 -0500
Date: Wed, 8 Nov 2000 21:19:09 +0100
From: Kurt Roeckx <Q@ping.be>
To: Jim Bonnet <jimbo@sco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sb.o support in 2.4-broken?
Message-ID: <20001108211909.A7107@ping.be>
In-Reply-To: <3A09BD3E.9F2FAF04@sco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <3A09BD3E.9F2FAF04@sco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 12:53:18PM -0800, Jim Bonnet wrote:
> I am using the 2.4.0-test10 kernel. I have a sound blaster 16 which
> works fine under 2.2.17.
> 
> I see that a while back someone posted on this problem previously but
> there were no answers I can find..
> 
> Is support for soundblaster16 ISA broken in the 2.4 kernel? Compiled in
> or used as a module I can not get it to work. I have passed sb=220,5,1,5
> during boot when compiled in and also sent those during insmod.

Use sb=0x220,5,1,5


Kurt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

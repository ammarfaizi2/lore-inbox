Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTFBEIq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 00:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTFBEIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 00:08:45 -0400
Received: from ns2.jaj.com ([66.93.21.106]:46311 "EHLO ns2.jaj.com")
	by vger.kernel.org with ESMTP id S261808AbTFBEIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 00:08:45 -0400
Date: Mon, 2 Jun 2003 00:22:09 -0400
From: Phil Edwards <phil@jaj.com>
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE kernel parameter (was: 2.4.20 SMP, a PDC20269, and a huge Maxtor disk)
Message-ID: <20030602042209.GA16248@disaster.jaj.com>
References: <20030529110903.79026.qmail@web11804.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529110903.79026.qmail@web11804.mail.yahoo.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 01:09:03PM +0200, Etienne Lorrain wrote:
> 
>   What I can propose you is:
>   - to first double check with your documentation that you typed in
>  the right address 0x10d2 (I have also seen wrong documentation).

The steps I followed to arrive at those numbers was the Ultra-DMA HOWTO:

    http://www.tldp.org/HOWTO/mini/Ultra-DMA-5.html#ss5.1

Once I had recompiled a new 2.4.20 with all the goodies, the ide2=
parameter became unneeded.  At least, I can boot without it.  Still having
GRUB problems, but no additional drive errors lately.  (Knock on wooden
backup tapes.)

I will try and do the other steps this week.


Thanks,
Phil

-- 
If ye love wealth greater than liberty, the tranquility of servitude greater
than the animating contest for freedom, go home and leave us in peace.  We seek
not your counsel, nor your arms.  Crouch down and lick the hand that feeds you;
and may posterity forget that ye were our countrymen.            - Samuel Adams

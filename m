Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbTLDHAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 02:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbTLDHAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 02:00:31 -0500
Received: from legolas.restena.lu ([158.64.1.34]:19090 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263137AbTLDHA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 02:00:29 -0500
Subject: RE: NForce2 pseudoscience stability testing (2.6.0-test11)
From: Craig Bradney <cbradney@zip.com.au>
To: b@netzentry.com
Cc: AMartin@nvidia.com, linux-kernel@vger.kernel.org
In-Reply-To: <3FCEC82F.9080309@netzentry.com>
References: <3FCEC82F.9080309@netzentry.com>
Content-Type: text/plain
Message-Id: <1070521223.4079.8.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Dec 2003 08:00:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok folks.. 

first crash here.. complete lockup. No idea how related it was to the
ones others are experiencing. 

Uptime at that point was 5 days 8:07. 

I was just running an emerge sync on Gentoo. I had been away from the PC
for a few hours (it had been recompiling mozilla in that time) but I had
woken it up for at least 20 mins before the crash.

So now the uptime run has died.. is there anything people want me to
test re kernel config?

I'm running round 80 wire IDE cables btw.

Craig


On Thu, 2003-12-04 at 06:37, b@netzentry.com wrote:
> Allen Martin wrote:
>  >Also are people who are having problems using rounded or flat
>  >cables?  It's
>  >possible the problem could be related to DMA CRC errors.
>  >Switching to flat
>  >cables can help with that.
>  >
>  >-Allen
> 
> I'm using the one that came with the board, flat 80 wire. It
> works under extreme stress in Windows 2000. It doesnt work
> in Linux.
> 
> 
> (I generated millions of interrupts from IDE and network
> (dual gigabit) in Windows 2000 on this very hardware for
> 3 days - thats why I came to the LKML, I did an empirical
> test that indicated Linux, and did some reading and others
> have had similar problems.)
> 
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


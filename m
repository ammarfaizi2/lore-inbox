Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVAYUda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVAYUda (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVAYUbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:31:10 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:30618
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262117AbVAYUa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:30:28 -0500
Subject: Re: wait_for_completion API extension addition
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41F6AA83.20306@sun.com>
References: <41F6AA83.20306@sun.com>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 21:30:22 +0100
Message-Id: <1106685023.4538.18.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 15:22 -0500, Mike Waychison wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Ingo,
> 
> I noticed that the wait_for_completion API extensions made it into mainline.
> 
> However, I posted that the patch in question is broken a while back:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110131832828126&w=2
> 
> Can we fix this?

We reposted a fixed version. It should not be the one from October which
made it upstream.

tglx



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbUBVPmT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 10:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbUBVPmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 10:42:19 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:63492 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261566AbUBVPmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 10:42:15 -0500
Subject: Re: 2.6.3-ck1
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: udok paldoswitz <udok@caramail.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1077425800011708@lycos-europe.com>
References: <1077425800011708@lycos-europe.com>
Content-Type: text/plain
Message-Id: <1077464528.1603.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sun, 22 Feb 2004 16:42:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-22 at 06:56, udok paldoswitz wrote:
> Gstreamer doesn't work anymore with ck1.
> I tried with elevator=deadline, but it does not solve the problem.
> Gstreamer works fine with kernel 2.6.3
> 
> I tested it with several programs which use gstreamer (rhythmbox, gst-launch, etc ...),
> but I get no error message.
> 
> Symptoms are :
> I get no sound when I try to play a sound file.
> The system is slowing down a lot.
> When gstreamer stops, the system come back to a good state.

I'm experiencing the same no-sound problems on my desktop computer. I
have had to revert to 2.6.3-bk3.


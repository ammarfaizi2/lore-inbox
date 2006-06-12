Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWFLWDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWFLWDQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWFLWDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:03:16 -0400
Received: from outbound-haw.frontbridge.com ([12.129.219.97]:42857 "EHLO
	outbound2-haw-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932416AbWFLWDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:03:15 -0400
X-BigFish: V
Message-ID: <448DE4A1.2030906@am.sony.com>
Date: Mon, 12 Jun 2006 15:03:13 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Matt Mackall <mpm@selenic.com>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 built-in command line
References: <1150148707.5257.284.camel@localhost.localdomain>
In-Reply-To: <1150148707.5257.284.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> This would also ensure compability with grub and friends, which I
> consider as a real strong argument to avoid breakage all over the place.

In any of the cases, wouldn't you have to set the option in order
to break something?
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================


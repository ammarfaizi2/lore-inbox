Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268684AbTGOPWD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268419AbTGOPOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:14:42 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:38060 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S268435AbTGOPFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:05:43 -0400
Subject: Re: 2.6.0-test1: ALSA problem
From: Chris Meadors <twrchris@hereintown.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: Amit Shah <shahamit@gmx.net>, linux-kernel@vger.kernel.org
In-Reply-To: <s5h7k6j3jvk.wl@alsa2.suse.de>
References: <200307151048.17586.shahamit@gmx.net>
	 <1058281075.8444.7.camel@clubneon.priv.hereintown.net>
	 <s5h7k6j3jvk.wl@alsa2.suse.de>
Content-Type: text/plain
Message-Id: <1058282265.8447.14.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 15 Jul 2003 11:17:45 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19cRbU-0004gN-AV*tcUvIP2ZqK.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-15 at 11:11, Takashi Iwai wrote:

> hmm, something gets wrong when no irq is generated and the pcm stream
> is forced to be closed.  i'll check this.
> 
> are you using a UP kernel or an SMP kernel?

UP but on a dual Athlon board with APIC and IO-APIC enabled.

> most likely you post won't appear on the list.
> the posts by non-subscribers are passed to the moderator, Dave Null.

Okay, trimming them from the CC list.

-- 
Chris


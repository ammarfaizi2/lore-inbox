Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUBPAiP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 19:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUBPAiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 19:38:15 -0500
Received: from [217.7.64.198] ([217.7.64.198]:54150 "EHLO mx1.net4u.de")
	by vger.kernel.org with ESMTP id S265268AbUBPAiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 19:38:04 -0500
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.3-rc3
Date: Mon, 16 Feb 2004 01:38:02 +0100
User-Agent: KMail/1.6
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org> <1076889243.11392.130.camel@gaston> <200402160129.32011.earny@net4u.de>
In-Reply-To: <200402160129.32011.earny@net4u.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402160138.02212.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 16. Februar 2004 01:29, Ernst Herzberg wrote:

Haaaalt! Yes, works, __but__:

If you start X, the console is gone. No recovery but reboot possible.

~Earny

> > Can you try this patch ?
>
> Yupp :-)
>
> Direct hit.
>
> Works immediatly. Ok, with some little cosmetic problems: Direct after
> boot you can see for (less than?)  ~1/10 sec the kernel screen in normal
> 25/80 resolution. After that you see the Pinguin on the top with funny
> blinking characters on the bottom, following with the normal boot
> messages. The funny characters scrolls out  normaly... look like that a
> random screen with resolution 25/80 are inserted when the fb are
> initialized...


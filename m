Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbULMAGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbULMAGy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 19:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbULMAGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 19:06:54 -0500
Received: from mail.dif.dk ([193.138.115.101]:14258 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262128AbULMAGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 19:06:52 -0500
Date: Mon, 13 Dec 2004 01:17:11 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Danny Beaudoin <beaudoin_danny@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Typo in kernel configuration (xconfig)
In-Reply-To: <BAY21-F18905FD4E8F32BE43C85BCF3AA0@phx.gbl>
Message-ID: <Pine.LNX.4.61.0412130114510.3369@dragon.hygekrogen.localhost>
References: <BAY21-F18905FD4E8F32BE43C85BCF3AA0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2004, Danny Beaudoin wrote:

> Hi!
> If I'm not at the right place, please forward this to the right person.
> 
> In Device Drivers/Graphics Support/Support for frame buffer devices:
> "On several non-X86 architectures, the frame buffer device is the
> only way to use the graphics hardware."
> 
> This should be 'x86' instead, as in the rest of the description.
> 
I don't think you are right. On x86 the framebuffer is not your only 
option, and on some non-x86 archs (like alpha for instance - at least 
this used to be the case when last I had an alpha box), fb is the 
only option. I think the text is correct as it stands.

-- 
Jesper Juhl



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbTEKIwQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 04:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTEKIwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 04:52:16 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:38813 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S261189AbTEKIwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 04:52:14 -0400
Date: Sun, 11 May 2003 11:04:29 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: david-b@pacbell.net
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild/kbuild for USB Gadgets (6/6)
In-Reply-To: <200305110609.h4B69Iko000763@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0305111102530.11279-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 May 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.1078.4.6, 2003/05/08 11:34:56-07:00, david-b@pacbell.net
> 
> 	[PATCH] kbuild/kbuild for USB Gadgets (6/6)

> +	   USB is a master/slave protocol, organized with with one master
                                                     ^^^^^^^^^
with with

> +	  Make this be the first driver you try using on top of any new
          ^^^^^^^^^^^^
Shouldn't the `be' be removed?

> +	  but is widely suppored by firmware for smart network devices.
                        ^^^^^^^^
supported

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267737AbUH3MFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267737AbUH3MFY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 08:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267774AbUH3MFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 08:05:23 -0400
Received: from witte.sonytel.be ([80.88.33.193]:12441 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267737AbUH3MFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 08:05:18 -0400
Date: Mon, 30 Aug 2004 14:04:23 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kenneth Lavrsen <kenneth@lavrsen.dk>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Summarizing the PWC driver questions/answers
In-Reply-To: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk>
Message-ID: <Pine.GSO.4.58.0408301402490.3353@waterleaf.sonytel.be>
References: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004, Kenneth Lavrsen wrote:
> - What is the next hardware or software - currently supported by Linux -
> that you will allow being made impossible to use for whatever fanatic
> reasons? (This is not exactly like the principles you stated in your book).

Hardware which needs a binary driver is not `supported by Linux'. You _know_
the so-called support may vanish in the (near) future.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

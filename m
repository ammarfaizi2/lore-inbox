Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWIAJpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWIAJpv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 05:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWIAJpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 05:45:51 -0400
Received: from witte.sonytel.be ([80.88.33.193]:5838 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751368AbWIAJpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 05:45:50 -0400
Date: Fri, 1 Sep 2006 11:45:07 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Willy Tarreau <wtarreau@hera.kernel.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       mtosatti@redhat.com
Subject: Re: Linux 2.4.34-pre2
In-Reply-To: <20060831201952.GA25445@hera.kernel.org>
Message-ID: <Pine.LNX.4.62.0609011142490.20760@pademelon.sonytel.be>
References: <20060831201952.GA25445@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006, Willy Tarreau wrote:
> This is Linux 2.4.34-pre2. It fixes several security issues which are

Apparently the patch is now relative to 2.4.34-pre1, not 2.4.33, while previous
2.4.*-pre* patches were relative to the previous full release?

This definitely breaks some scripts (incl. mine ;-(

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263005AbUJ1Rdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbUJ1Rdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbUJ1RdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:33:15 -0400
Received: from witte.sonytel.be ([80.88.33.193]:48046 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263005AbUJ1RbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:31:02 -0400
Date: Thu, 28 Oct 2004 19:30:55 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
Subject: Re: New kbuild filename: Kbuild
In-Reply-To: <20041028190020.GB9004@mars.ravnborg.org>
Message-ID: <Pine.GSO.4.61.0410281930250.4228@waterleaf.sonytel.be>
References: <20041028185917.GA9004@mars.ravnborg.org> <20041028190020.GB9004@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004, Sam Ravnborg wrote:
> --- a/Documentation/kbuild/makefiles.txt	2004-10-28 20:46:24 +02:00
> +++ b/Documentation/kbuild/makefiles.txt	2004-10-28 20:46:24 +02:00
>  This document is aimed towards normal developers and arch developers.
>  
>  
> -=== 3 The kbuild Makefiles
> +=== 3 The kbuild files
>  
>  Most Makefiles within the kernel are kbuild Makefiles that use the
>  kbuild infrastructure. This chapter introduce the syntax used in the
>  kbuild makefiles.
> +The preferred name for the kbuild files is 'Kbuild' but 'Makefile' will
> +continue to be supported. All new developmen is expected to use the
                                     ^^^^^^^^^^
				     development
> +Kbuild filename.
>  
>  Section 3.1 "Goal definitions" is a quick intro, further chapters provide
>  more details, with real examples.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbUCRJVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 04:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbUCRJVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 04:21:41 -0500
Received: from witte.sonytel.be ([80.88.33.193]:14215 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262462AbUCRJVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 04:21:39 -0500
Date: Thu, 18 Mar 2004 10:21:31 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jakub Bogusz <qboosh@pld-linux.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH 2.6][RESEND] fbcon margins colour
 fix
In-Reply-To: <20040317233135.GB3510@satan.blackhosts>
Message-ID: <Pine.GSO.4.58.0403181020320.10688@waterleaf.sonytel.be>
References: <20040317233135.GB3510@satan.blackhosts>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Jakub Bogusz wrote:
> I sent it a few times to linux-kernel and at least one to
> linux-fbdev-devel, but haven't seen any comments - and this annoying
> changing margins colour seems to be still there in 2.6.4 (at least on
> tdfxfb).

What happens on `reverse video' (i.e. black on white, like Sun) graphics cards?
In that case the overscan color is white.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbSL0Xre>; Fri, 27 Dec 2002 18:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265266AbSL0Xre>; Fri, 27 Dec 2002 18:47:34 -0500
Received: from are.twiddle.net ([64.81.246.98]:39817 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265255AbSL0Xrd>;
	Fri, 27 Dec 2002 18:47:33 -0500
Date: Fri, 27 Dec 2002 15:54:51 -0800
From: Richard Henderson <rth@twiddle.net>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Linux-fbdev-devel] [FB PATCH]
Message-ID: <20021227155451.A3942@twiddle.net>
Mail-Followup-To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
References: <20021227150934.A3005@twiddle.net> <Pine.GSO.4.21.0212280025150.17067-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0212280025150.17067-100000@vervain.sonytel.be>; from Geert.Uytterhoeven@sonycom.com on Sat, Dec 28, 2002 at 12:25:58AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 12:25:58AM +0100, Geert Uytterhoeven wrote:
> Strange, it's defined in drivers/video/fbmem.c in my copy of 2.5.53.

Ah.  It's not exported, so fbcon as a module fails.
Not sure how I missed it with a grep...


r~

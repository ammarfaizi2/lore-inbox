Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267108AbSKWWC7>; Sat, 23 Nov 2002 17:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbSKWWC7>; Sat, 23 Nov 2002 17:02:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:61866 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267108AbSKWWC6>;
	Sat, 23 Nov 2002 17:02:58 -0500
Date: Sat, 23 Nov 2002 14:08:10 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Justin Hibbits <jrh29@po.cwru.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ps2 mouse remapping keyboard
Message-Id: <20021123140810.6738d073.rddunlap@osdl.org>
In-Reply-To: <20021123211247.GB413@lothlorien.cwru.edu>
References: <20021123211247.GB413@lothlorien.cwru.edu>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2002 16:12:47 -0500 Justin Hibbits <jrh29@po.cwru.edu> wrote:

| I'm not subscribed right now, but I have a major problem.  For some reason,
| sometimes when I startup either gpm or X, my keyboard gets remapped, so that
| several of the keys return keycode 0x70 or 0x71, while others return 0x56, and
| the rest return extended e0/e1 keycodes.  I'm unsure why this happens.  It
| started happening when I installed dri drivers off dri.sf.net, but even after
| removing those drivers, deleting the kernel source tree, and starting from
| scratch, it still happens.  I'm at a loss, so if someone can shed some light on
| this, I'd be grateful.
| this happens sporadically, so not exactly sure what the problem is.  Hopefully
| this won't happen when I get a USB mouse/keyboard for christmas :) /me crosses
| fingers.

No idea, but you seem to think that it's software, but
could it be a cable problem?

BTW, the main reason that I'm replying is that you gave no clues
about what versions of software you are using.

--
~Randy

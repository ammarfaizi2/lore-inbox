Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261478AbSKBWnb>; Sat, 2 Nov 2002 17:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261481AbSKBWna>; Sat, 2 Nov 2002 17:43:30 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:7950 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261478AbSKBWna>;
	Sat, 2 Nov 2002 17:43:30 -0500
Date: Sat, 2 Nov 2002 23:48:38 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Marek Habersack <grendel@debian.org>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Message-ID: <20021102224838.GB15134@mars.ravnborg.org>
Mail-Followup-To: Marek Habersack <grendel@debian.org>,
	linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
References: <20020625222135.GA617@free.fr> <3DC378D0.5080703@iinet.net.au> <20021102203608.GB731@gallifrey> <20021102210724.B8549@flint.arm.linux.org.uk> <20021102224318.GA3206@thanes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102224318.GA3206@thanes.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 11:43:18PM +0100, Marek Habersack wrote:
> Exactly. On Debian the qt2 devel stuff is 17MB (!). Yesterday I was trying
> to compile 2.5.45 just to see that even doing make menuconfig (which I
> always use) breaks because of missing qt.
This is properly fixed in Linus's tree.

	Sam

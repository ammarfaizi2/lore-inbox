Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262575AbTCITYD>; Sun, 9 Mar 2003 14:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262578AbTCITYC>; Sun, 9 Mar 2003 14:24:02 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29965 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262575AbTCITYB>;
	Sun, 9 Mar 2003 14:24:01 -0500
Date: Sun, 9 Mar 2003 20:34:39 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig update
Message-ID: <20030309193439.GA15837@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303090432200.32518-100000@serv> <20030309190103.GA1170@mars.ravnborg.org> <Pine.LNX.4.44.0303092028020.32518-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303092028020.32518-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 08:30:02PM +0100, Roman Zippel wrote:
> What do you mean? 2.5.64 has no V option.

It is only present in linus-BK-latest - sorry.
"make V=0" is a shorthand for "make KBUILD_VERBOSE=0".
In other words a way to disable the 'noise' generated
when building the kernel.

	Sam

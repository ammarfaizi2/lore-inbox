Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318924AbSHMDbZ>; Mon, 12 Aug 2002 23:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318925AbSHMDbZ>; Mon, 12 Aug 2002 23:31:25 -0400
Received: from zok.SGI.COM ([204.94.215.101]:1949 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S318924AbSHMDbY>;
	Mon, 12 Aug 2002 23:31:24 -0400
Message-ID: <3D587E89.4EF18102@alphalink.com.au>
Date: Tue, 13 Aug 2002 13:35:37 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org.com>
CC: Tom Rini <trini@kernel.crashing.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [patch] config language dep_* enhancements
References: <Pine.LNX.4.44.0208130053360.28515-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> I only used it as an example, because my tool has problems to
> automatically convert this construct into something useful (e.g. because
> of CONFIG_WILLOW in 2 seperate choice statements).

You too?  I had to rewrite my branch merging code to make CONFIG_WILLOW fit.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.

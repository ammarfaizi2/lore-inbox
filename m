Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbTAZVSF>; Sun, 26 Jan 2003 16:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266994AbTAZVSF>; Sun, 26 Jan 2003 16:18:05 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:34256 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S266989AbTAZVSF>; Sun, 26 Jan 2003 16:18:05 -0500
Date: Sun, 26 Jan 2003 23:23:53 +0100
From: Christian Zander <zander@minion.de>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Christian Zander <zander@minion.de>, Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030126222353.GC394@kugai>
Reply-To: Christian Zander <zander@minion.de>
References: <20030126132923.GB396@kugai> <Pine.LNX.4.44.0301261144430.15538-100000@chaos.physics.uiowa.edu> <20030126215714.GA394@kugai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030126215714.GA394@kugai>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 10:57:14PM +0100, Christian Zander wrote:
> 
> Is that so? Does kbuild determine that vermagic.o needs rebuilding if
> the compiler version changed?
> 

Nevermind, I just checked - it does.

-- 
christian zander
zander@minion.de

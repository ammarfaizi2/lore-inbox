Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266793AbSKSUgH>; Tue, 19 Nov 2002 15:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267152AbSKSUgH>; Tue, 19 Nov 2002 15:36:07 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:65292 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266793AbSKSUgG>;
	Tue, 19 Nov 2002 15:36:06 -0500
Date: Tue, 19 Nov 2002 21:43:09 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Larry McVoy <lm@work.bitmover.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC/CFT] Separate obj/src dir
Message-ID: <20021119204309.GB15161@mars.ravnborg.org>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20021119201110.GA11192@mars.ravnborg.org> <Pine.LNX.3.95.1021119151730.5943A-100000@chaos.analogic.com> <20021119123115.C16028@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119123115.C16028@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 12:31:15PM -0800, Larry McVoy wrote:
> It can be really nice to maintain a bunch of different architectures at
> the same time from the same tree.  It also makes it really easy to 
> "clean" a tree.
> 
> On the other hand, I do wonder whether ccache could be used to get the
> same effect.  Sam?
I have never taken the time to look into ccache, so I dunno.

	Sam

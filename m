Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261405AbTCJTCH>; Mon, 10 Mar 2003 14:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261406AbTCJTCH>; Mon, 10 Mar 2003 14:02:07 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:33033 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261405AbTCJTCF>;
	Mon, 10 Mar 2003 14:02:05 -0500
Date: Mon, 10 Mar 2003 20:12:45 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig update
Message-ID: <20030310191244.GA1715@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303090432200.32518-100000@serv> <20030309190103.GA1170@mars.ravnborg.org> <Pine.LNX.4.44.0303092028020.32518-100000@serv> <20030309193439.GA15837@mars.ravnborg.org> <Pine.LNX.4.44.0303092115310.32518-100000@serv> <20030309211518.GA18087@mars.ravnborg.org> <Pine.LNX.4.44.0303101046590.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303101046590.5042-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 11:00:02AM +0100, Roman Zippel wrote:

> verbose mode. If you skip the oldconfig step, the config tool is called 
> anyway and checks the configuration and only asks as necessary. The same 
> mode could be used for oldconfig, but I didn't want to change the 
> behaviour needlessly.

The reason to respond is that all the output from conf looks useless.
What is the usage of conf being so verbose?
If it is required then keep it. But making conf that verbose only
because configure was that verbose . There is no point in that.

Not a needlessly change, but more in the area - it was about time..

	Sam

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbTETV66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 17:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbTETV66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 17:58:58 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:20098
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261275AbTETV65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 17:58:57 -0400
Date: Tue, 20 May 2003 18:01:47 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Nigel Cunningham <ncunningham@clear.net.nz>
cc: alexander.riesen@synopsys.COM, Milton Miller <miltonm@bga.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "" <mikpe@csd.uu.se>
Subject: Re: 2.5.69+bk: oops in apmd after waking up from suspend mode
In-Reply-To: <1053461400.2055.7.camel@laptop-linux>
Message-ID: <Pine.LNX.4.50.0305201800560.20429-100000@montezuma.mastecende.com>
References: <3ECA05FA.6090008@gmx.net> <200305201634.h4KGY9VJ049544@sullivan.realtime.net>
 <20030520170054.GQ32559@Synopsys.COM> <20030520171759.GR32559@Synopsys.COM>
 <1053461400.2055.7.camel@laptop-linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 May 2003, Nigel Cunningham wrote:

> On Wed, 2003-05-21 at 05:17, Alex Riesen wrote:
> > It is harder to trigger, but possible.
> > I booted with init=/bin/bash. Than I started this
> > find / -type f -fprint /dev/stderr -print | xargs cat > /dev/null
> > and began going in suspend mode and back.
> > 
> > At some point it broke with oops above.

Very nice, i'll try it and see what dies

	Zwane
-- 
function.linuxpower.ca

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTETQsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 12:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTETQsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 12:48:18 -0400
Received: from boden.synopsys.com ([204.176.20.19]:50852 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP id S263418AbTETQsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 12:48:17 -0400
Date: Tue, 20 May 2003 19:00:54 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Milton Miller <miltonm@bga.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       mikpe@csd.uu.se
Subject: Re: 2.5.69+bk: oops in apmd after waking up from suspend mode
Message-ID: <20030520170054.GQ32559@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
References: <3ECA05FA.6090008@gmx.net> <200305201634.h4KGY9VJ049544@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305201634.h4KGY9VJ049544@sullivan.realtime.net>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milton Miller, Tue, May 20, 2003 18:34:09 +0200:
> Shouldn't this just use active_mm?   Can somebody test?

It helped.

> by the way, I saw this with a 486 kernel compiled by
> gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)
> 
> on a Toshiba 2105 (aka 2100 +- sw) 486DX2/50, although I am not
> at that computer presenlty to test.
> 

Also the stability problems I mentioned before gone.

-alex


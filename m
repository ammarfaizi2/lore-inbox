Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266360AbUFUSKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266360AbUFUSKJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 14:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266365AbUFUSKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 14:10:09 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:17926 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266360AbUFUSKF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 14:10:05 -0400
Date: Mon, 21 Jun 2004 20:10:03 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Matroxfb in 2.6 still doesn't work in 2.6.7
Message-ID: <20040621181003.GB28577@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040618211031.GA4048@irc.pl> <20040619190503.GB17053@vana.vc.cvut.cz> <20040619193053.GA3644@irc.pl> <20040619203954.GC17053@vana.vc.cvut.cz> <20040620160437.GA29046@irc.pl> <20040620170114.GA4683@vana.vc.cvut.cz> <20040620213743.GA6974@irc.pl> <20040621013136.GB4683@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040621013136.GB4683@vana.vc.cvut.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 03:31:36AM +0200, Petr Vandrovec wrote:
> > > > > video=matroxfb:vesa:0x11A,right:48,hslen:112,left:248,hslen:112,lower:1,vslen:3,upper:48
> > > > > maybe with ',sync:3' if +hsync/+vsync are mandatory for your monitor.
> 
> 1280x1024-60 just selects some videomode fbdev subsystem thinks your monitor should use,
> while vesa:0x11A selects videomode I think you should use.

 Could fbdev be changed to select the same videomode as vesa: switch?

-- 
Tomasz Torcz                                                       72->|   80->|
zdzichu@irc.-nie.spam-.pl                                          72->|   80->|


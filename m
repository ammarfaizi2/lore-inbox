Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbUDJQpq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 12:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUDJQpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 12:45:46 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:25351 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262059AbUDJQpp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 12:45:45 -0400
Date: Sat, 10 Apr 2004 18:45:45 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Total freeze switching X->fb (matrox)
Message-ID: <20040410164545.GA10280@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040410163758.GA7704@lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040410163758.GA7704@lan>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 06:37:58PM +0200, legion wrote:
> The problem is: framebuffer (matroxfb) works fine, X (xfree 4.3 or Xorg
> 6.7) works fine, but sometimes when i hit "ctrl alt F1" for switching
> on the console, the system freeze.

> video card: Matrox G400 DH on nvidia nforce2 motherboard
> kernel: vanilla 2.6.3+ (nforce2 agp/matrox drm/matroxfb support)
> X server: Xfree 4.3.0 or Xorg r6.7 using "mga" driver

 It also happens with Matrox G550 on VIA board.
All 2.6.x kernels. XFree86 4.3 and 4.4.

 And 1280x1024-16@60 do not work (in fb, X is fine) :-(

-- 
Tomasz Torcz                Only gods can safely risk perfection,     
zdzichu@irc.-nie.spam-.pl     it's a dangerous thing for a man.  -- Alia


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262159AbSJNVYv>; Mon, 14 Oct 2002 17:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262188AbSJNVYv>; Mon, 14 Oct 2002 17:24:51 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:53163 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S262159AbSJNVYt>;
	Mon, 14 Oct 2002 17:24:49 -0400
Date: Mon, 14 Oct 2002 23:30:35 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: "Murray J. Root" <murrayr@brain.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.42 loses keyboard and mouse when starting X
Message-ID: <20021014233035.A20926@balu.sch.bme.hu>
References: <20021012094833.GA1622@Master.Wizards>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021012094833.GA1622@Master.Wizards>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, Oct 12, 2002 at 05:48:33AM -0400, Murray J. Root wrote:
> Not sure what info is needed here - there are no error messages
> anywhere.
> 
> ASUS P4S533 (SiS645DX chipset)
> P4 2Ghz cpu
> 1G PC2700 RAM
> SBLive! value (using ALSA driver)
> NVidia GeForce2 GTS (using XFree86 nv driver)
> PS/2 Keyboard & mouse
> 
> Mandrake 9.0
> XFree86 4.2.1
> 
> Boot to console & login with no problem.
> Run console apps with no problem.
> run startx and X appears to start normally, but keyboard and mouse
> are dead.
> Only thing in .xinitrc is
>   exec /usr/X11R6/bin/startfluxbox
> 
> No new messages in any log files.
> 
> Happens with all 2.5.4x including -ac

Do you have a PS/2 mouse? Try starting X without mouse, to see if it is 
the problem.

-- 
pozsy

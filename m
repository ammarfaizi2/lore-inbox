Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262683AbSJHCvw>; Mon, 7 Oct 2002 22:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262716AbSJHCvw>; Mon, 7 Oct 2002 22:51:52 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:61942 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S262683AbSJHCvs>; Mon, 7 Oct 2002 22:51:48 -0400
Date: Mon, 7 Oct 2002 22:57:38 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40 loses keyboard and mouse in X
Message-ID: <20021008025738.GA1848@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021007031916.GA1732@Master.Wizards>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021007031916.GA1732@Master.Wizards>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 11:19:16PM -0400, Murray J. Root wrote:
> Not sure what info is needed here - there are no error messages anywhere.
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
> Same thing happens with 2.5.40-ac2 & -ac4.
> 

Same thing happens in 2.5.41-ac1

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 


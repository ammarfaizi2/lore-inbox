Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262424AbTCIFti>; Sun, 9 Mar 2003 00:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262426AbTCIFti>; Sun, 9 Mar 2003 00:49:38 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:35846 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262424AbTCIFth>; Sun, 9 Mar 2003 00:49:37 -0500
Date: Sun, 9 Mar 2003 06:54:53 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Michal Semler <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org, vandrove@vc.cvut.cz
Subject: Re: very buggy 3DFx framebuffer support!!! :(
Message-ID: <20030309055453.GA9064@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <E18rmiu-0000ew-00@notas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18rmiu-0000ew-00@notas>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Semler <cijoml@volny.cz>
Date: Sat, Mar 08, 2003 at 11:23:18PM +0100
> Hello,
> 
> I found out very buggy 3DFx framebuffer support :(
> 
> when I select nothing when console bootings, I got white background under 
> Tux, rolling up with black background of text. Then everything under Tux has 
> black background and white text, but there, where is tux icon everything on 
> the right side of the icon has still white background
> 
> when I select in lilo 
> append="video=tdfx:1024x768-24@75"
> 
> my console gets screws up and I can't see anything under it. X windows but 
> works.
> 
> When I boot computer without append and then call it with fbset -a 
> 1024x768-75 things are the same ;( and I still can select Xwindows with alt+f7
> 
> Please can anybody fix this?
> 
> Linux 2.4.20 vanilla, gcc 3.0.4, Debian woody 3.0r1, 3DFx card, P3 733 
> Coppermine
> 
What 3dfx card? Output in log-files? Dmesg-output? output of 'dmesg' ?

Jurriaan
-- 
If Big Brother is watching you, stare back, he doesn't like it.
	Shannon
GNU/Linux 2.5.63 SMP/ReiserFS 3948 bogomips load av: 0.24 0.37 0.20

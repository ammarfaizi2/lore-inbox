Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbUKFVMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbUKFVMZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 16:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbUKFVMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 16:12:25 -0500
Received: from adsl-70-241-70-1.dsl.hstntx.swbell.net ([70.241.70.1]:23944
	"EHLO leamonde.no-ip.org") by vger.kernel.org with ESMTP
	id S261473AbUKFVMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 16:12:23 -0500
Date: Sat, 6 Nov 2004 15:12:22 -0600
From: "Camilo A. Reyes" <camilo@leamonde.no-ip.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Console 80x50 SVGA
Message-ID: <20041106211222.GA18108@leamonde.no-ip.org>
References: <20041105224206.GA16741@leamonde.no-ip.org> <20041106073901.GA783@alpha.home.local> <20041106184112.GC16891@leamonde.no-ip.org> <20041106194343.GA29874@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106194343.GA29874@middle.of.nowhere>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 08:43:43PM +0100, Jurriaan wrote:
> From: Camilo A. Reyes <camilo@leamonde.no-ip.org>
> Date: Sat, Nov 06, 2004 at 12:41:12PM -0600
> > 
> > If I may ask what vga number are you using to set it to 1024x768.
> > I believe I have tried it before with no success, but I'm willing
> > to try again.
> 
> Might I again refer you to google?
> 
> Searching for 'linux framebuffer 1024x768 vga=' gives me 11.800 hits,
> which surely is enough to choose from. Also, this is mentioned in
> /usr/src/linux-<whatever version>/Documentation/fb/<somefile, depending
> on your framebuffer, which you didn't mention>. Those docs were lovingly
> crafted by kernel hackers hoping to answer all the questions users may
> have, so it would be a shame not to use them, right?
> 
> Good luck,
> Jurriaan
> -- 
> A seminar on Time Travel will be held two weeks ago.
> Debian (Unstable) GNU/Linux 2.6.9-mm1 2x6078 bogomips load 0.05

Actually I knew what the answer to that question was, its 795 for 1024x768
and 32 bpp, I was just asking to check for consistency. :-P Anyhow, that
documentation talks about using fbset, I gave that a shot and now my entire
tty is dead. :-( It also mentions lots of bugs, hmmm not sure if it's even
worth looking deeper into this. But let me set up some kernel parameters
and restart my system to see what happens, I always refrain from restarting
the system, but oh well.

BTW, my framebuffer its the aty128fb.

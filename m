Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265242AbUAER2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbUAER2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:28:42 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:5504 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265242AbUAER2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:28:40 -0500
Date: Mon, 5 Jan 2004 18:29:00 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Daniel Jacobowitz <dan@debian.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040105172900.GA359@ucw.cz>
References: <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl> <Pine.LNX.4.58.0401050749490.21265@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401050749490.21265@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 08:13:26AM -0800, Linus Torvalds wrote:

> But the thing is, some things you simply _cannot_ number. For example, a
> two-dimensional space is innumerable - you need more than one integer
> number to look things up.  So is the set of real numbers (but not the set 
> of fractions), etc etc.

Two dimensional discrete space (*) is enumerable. Just start at [0,0]
and assign numbers going around the center in a growing spiral (**).
That way you assign a number to every point in that space. This is very
similar to the trick used to demonstrate fractions are enumerable.

(*)  The one where you can use two integers to look things up.
(**) Assuming the coordinates can be negative. For non-negative
     it's even easier.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

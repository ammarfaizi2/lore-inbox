Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266239AbUALU7o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 15:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266235AbUALU7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 15:59:21 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:23190 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266239AbUALU7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 15:59:11 -0500
Date: Wed, 7 Jan 2004 10:57:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Daniel Jacobowitz <dan@debian.org>,
       Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040107095743.GA467@openzaurus.ucw.cz>
References: <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105035037.GD4176@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401041954010.2162@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401041954010.2162@home.osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> If nothing else, things like SATA will end up meaning that the device you 
> were used to seeign as /dev/hdc will suddenly show up as /dev/scd0 
> instead. Just because you changed the cabling while you upgraded to a 

I do not see easy solution for cdroms... UUID is not going to work there...
				Pavel


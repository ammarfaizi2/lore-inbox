Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266037AbUAFACn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266036AbUAFABS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:01:18 -0500
Received: from mail.kroah.org ([65.200.24.183]:60584 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266037AbUAFAAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:00:33 -0500
Date: Mon, 5 Jan 2004 16:00:15 -0800
From: Greg KH <greg@kroah.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Daniel Jacobowitz <dan@debian.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040106000014.GL30464@kroah.com>
References: <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl> <Pine.LNX.4.58.0401050749490.21265@home.osdl.org> <20040105205228.A1092@pclin040.win.tue.nl> <Pine.LNX.4.58.0401051224480.2153@home.osdl.org> <20040106001326.A1128@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040106001326.A1128@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 12:13:26AM +0100, Andries Brouwer wrote:
> On Mon, Jan 05, 2004 at 12:38:54PM -0800, Linus Torvalds wrote:
> 
> > Have you even _tried_ udev?
> 
> Yes, and it works reasonably well. I have version 012 here.
> Some flaws will be fixed in 013 or so.

What flaws would that be?  The short time delay for partitions?  Or
something else?

> Some difficulties are of a more fundamental type, not so easy to fix.

Such as?

> But udev is an entirely different discussion. Some other time.

Feel free to bring it up on the linux-hotplug-devel list whenever you
wish.

thanks,

greg k-h

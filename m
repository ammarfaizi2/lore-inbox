Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUAEHrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 02:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265892AbUAEHrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 02:47:24 -0500
Received: from mail.kroah.org ([65.200.24.183]:10666 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265825AbUAEHrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 02:47:22 -0500
Date: Sun, 4 Jan 2004 23:47:17 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Daniel Jacobowitz <dan@debian.org>,
       Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040105074717.GB13651@kroah.com>
References: <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105035037.GD4176@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401041954010.2162@home.osdl.org> <20040105043830.GE4176@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401042043020.2162@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401042043020.2162@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 08:52:56PM -0800, Linus Torvalds wrote:
> 
> But since you brought it up: do you actually have anything else that can
> open a remote IMAP file with a few thousand messages without taking ages
> for it, and that you don't have to mouse around with? I'd like a graphical
> interface for configuring stuff etc, but I sure as hell don't want to find
> some f*ing icon to save a few messages that I selected in-order to my
> "doit" queue or go to the next one, or pipe the thing to a shell-script,
> or any number of things that are my actual _job_.

mutt can provide a path for a recovering pine addict.  I did that a
number of years ago and have been quite happy since.  I can't vouch for
its IMAP speeds (seems to be fast enough for me, as long as I don't try
to do a filter on a large IMAP folder), but the other tasks you do
(selecting, piping, etc.) work very well.

I even think there's a mutt config file that duplicates all of the
default pine keystrokes just to make moving easier.

The message threading was reason enough for me to switch, although I've
heard rumors that pine can handle that now.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265274AbUAERwt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbUAERwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:52:49 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:44467 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265274AbUAERwn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:52:43 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 5 Jan 2004 09:52:45 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Linus Torvalds <torvalds@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
       Daniel Jacobowitz <dan@debian.org>, Rob Love <rml@ximian.com>,
       <rob@landley.net>, Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <20040105172900.GA359@ucw.cz>
Message-ID: <Pine.LNX.4.44.0401050944420.17134-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004, Vojtech Pavlik wrote:

> On Mon, Jan 05, 2004 at 08:13:26AM -0800, Linus Torvalds wrote:
> 
> > But the thing is, some things you simply _cannot_ number. For example, a
> > two-dimensional space is innumerable - you need more than one integer
> > number to look things up.  So is the set of real numbers (but not the set 
> > of fractions), etc etc.
> 
> Two dimensional discrete space (*) is enumerable. Just start at [0,0]
> and assign numbers going around the center in a growing spiral (**).
> That way you assign a number to every point in that space. This is very
> similar to the trick used to demonstrate fractions are enumerable.

Vojtech, a spiral (in the math sense) won't work because whatever 
continuos function you choose for the radius, you are going to skip 
integers when the radius grows (and duplicate them when it's small). Also, 
IIRC, fractions are enumerable because they're a mapping from two 
enumerable spaces (integers): F = F(I1, I2) = I1 / I2.



- Davide




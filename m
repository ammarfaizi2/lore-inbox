Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTIWKvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 06:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTIWKvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 06:51:11 -0400
Received: from csl2.consultronics.on.ca ([204.138.93.2]:43933 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id S261939AbTIWKvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 06:51:10 -0400
Date: Tue, 23 Sep 2003 06:51:08 -0400
From: Greg Louis <glouis@dynamicro.on.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Keyboard oddness.
Message-ID: <20030923105107.GA1280@athame.dynamicro.on.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200309201633.22414.rob@landley.net> <200309221506.08331.rob@landley.net> <20030923000647.A1128@pclin040.win.tue.nl> <200309221923.28519.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200309221923.28519.rob@landley.net>
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20030922 (Mon) at 1923:28 -0500, Rob Landley wrote:
> On Monday 22 September 2003 17:06, Andries Brouwer wrote:
> > On Mon, Sep 22, 2003 at 03:06:08PM -0500, Rob Landley wrote:
> 
> > > Any clues?  (This happens to me at least once an hour...)
> >
> > Some people have been reporting missing key releases (maybe also you),
> > but these are all missing key presses. It is easiest to blame the
> > keyboard, even though I could imagine ways to blame the kernel.
> >
> > What about 2.4?
> 
> 2.4 worked for me when I used it.  I haven't booted 2.4 in weeks

I've been missing keypresses for at least six weeks; at first I too
thought the keyboard was the culprit, but I've anecdotal grumblings in
email from several 2.4 users who thought the same of their own machines.
Not very likely to be a keyboard-infesting virus out there... 
Frequency seems to be of the order of 0.001 on average.

It might not be only keyboard interrupts that are being missed, but I
have no hard data -- just a gut feeling that occasional ethernet
packets are going astray too for no known good reason.  Hasn't been
enough of a problem to trigger serious investigation.

-- 
| G r e g  L o u i s         | gpg public key: 0x400B1AA86D9E3E64 |
|  http://www.bgl.nu/~glouis |   (on my website or any keyserver) |
|  http://wecanstopspam.org in signatures helps fight junk email. |

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTJ1StZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 13:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTJ1StZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 13:49:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:40385 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261309AbTJ1StY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 13:49:24 -0500
Date: Tue, 28 Oct 2003 10:48:26 -0800
From: Greg KH <greg@kroah.com>
To: Mark Bellon <mbellon@mvista.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: ANNOUNCE: User-space System Device Enumeration (uSDE)
Message-ID: <20031028184825.GB7432@kroah.com>
References: <Pine.LNX.4.33.0310280901490.7139-100000@osdlab.pdx.osdl.net> <3F9EB17F.9020308@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9EB17F.9020308@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 28, 2003 at 11:12:15AM -0700, Mark Bellon wrote:
> I can't respond to the emotion and ad hominum references in this 
> message. The uSDE announcement is my first posting. I can't address any 
> past dealings with MontaVista.

It might be your first public posting.  But it is not your first email
to people here ever.  I have a few emails from you lying around here
from back in Feb and March of this year in which you detailed this
project.  And you have been aware of udev from at least April, as it's
code has been public since then.

I also have email messages from Intel employees who were helping you
with uSDE over the past few months, asking questions about different
things that udev does, in order to get a better understanding of it.
I'm guessing that was done to provide that functionality in uSDE, which
is fine.

The major frustration of mine is why, if you found udev lacking for one
reason or another, did you decide to not help us out, and instead go off
and work on your own, in secret?  We could really use the help with
udev, and having at least 2 full time people working on it (like it
looks like uSDE has) would make a real difference. 

> The uSDE ideas and implementation was started with the OSDL requirements 
> in August of 2002.
> This is the first time any form of it has been posted.

Again, in public.  I have older code drops of yours in my email folders.

> From time-to-time, since the project started, ideas related to it have
> been floated with the community.  The feedback was carefully listened
> to and utitized in the implementation that was just posted.

I have provided help to you and your team over time, but that has been a
one-way street.  Help has not flowed back the other way, even when we
have asked for it (help with udev, or with the kernel changes that are
required for udev or uSDE to work properly.)  That is why I am
frustrated, and I think that others in the open source community have
the same frustration.

udev isn't going away any time soon, and I am committed to working on it
for quite some time in order to address issues people have raised.  If
you want to spend your time on uSDE, that's up to you.  I'm very willing
to work with your team, if your team is willing to work with us.

thanks,

greg k-h

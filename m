Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272325AbTHFVmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272355AbTHFVmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:42:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:23266 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272325AbTHFVmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:42:11 -0400
Date: Wed, 6 Aug 2003 14:40:38 -0700
From: Greg KH <greg@kroah.com>
To: Paul Dickson <dickson@permanentmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: My report on running 2.6.0-test2 on a Dell Inspiron 7000 (lost USB mouse)
Message-ID: <20030806214037.GB7618@kroah.com>
References: <20030806021621.2da5a850.dickson@permanentmail.com> <20030806030337.5a9dd2c6.dickson@permanentmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806030337.5a9dd2c6.dickson@permanentmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 03:03:37AM -0700, Paul Dickson wrote:
> On Wed, 6 Aug 2003 02:16:21 -0700, Paul Dickson wrote:
> 
> > But all is not perfect.  I'll attach the problems I had as replies (so
> > each has it's own message thread).
> 
> After spending the day visiting relatives, I came back to the notebook and
> put something down nearby.  I then went away for a moment and upon
> returning discovered the screen unblanked but the mouse not functioning. 
> Flipping workspaces relieved my fear that 2.6.0-test2 had crashed, but
> still no mouse.
> 
> So I decided to unplug and replug in the mouse (its USB after all).
> 
> This allowed the mouse to function again.
> 
> This is what was recorded in the message log:

Known issue.  Is fixed in Linus's latest tree.  If this still shows up
in 2.6.0-test3, please let us know.

thanks,

greg k-h

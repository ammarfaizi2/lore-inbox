Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266052AbUAFAxk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266055AbUAFAxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:53:40 -0500
Received: from CPE-24-163-213-29.mn.rr.com ([24.163.213.29]:42427 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S266052AbUAFAxe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:53:34 -0500
Subject: Re: udev and devfs - The final word
From: Shawn <core@enodev.com>
To: Greg KH <greg@kroah.com>
Cc: Mark Mielke <mark@mark.mielke.cc>, Linus Torvalds <torvalds@osdl.org>,
       Andries Brouwer <aebr@win.tue.nl>, Daniel Jacobowitz <dan@debian.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040106004343.GB1043@kroah.com>
References: <Pine.LNX.4.58.0401041847370.2162@home.osdl.org>
	 <20040105030737.GA29964@nevyn.them.org>
	 <Pine.LNX.4.58.0401041918260.2162@home.osdl.org>
	 <20040105132756.A975@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401050749490.21265@home.osdl.org>
	 <20040105205228.A1092@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401051224480.2153@home.osdl.org>
	 <1073341077.21797.17.camel@localhost>
	 <20040105222559.GA3513@mark.mielke.cc>
	 <1073343916.21797.21.camel@www.enodev.com>
	 <20040106004343.GB1043@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1073350411.21797.30.camel@www.enodev.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 18:53:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm embarrassed to say I did not read that.

I'm starting to wonder what some folks are complaining about. WRT
practicality and useability, udev about covers it once alsa and vmware
;) get sysfs-ified.

My own foray into udev was a little lacking owing to these little
issues.

On Mon, 2004-01-05 at 18:43, Greg KH wrote:
> In summary, udev doesn't care squat about the major/minor that the
> kernel has used for a device.  It merely uses those numbers and creates
> a /dev entry with them, assigned to a name that it comes up with.
> 
> Does that help out?  The udev OLS paper might also help explain some of
> this.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUKTA1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUKTA1E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbUKTA0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:26:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36245 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261706AbUKTAXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:23:02 -0500
Date: Fri, 19 Nov 2004 16:22:55 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Linux support for SiLabs CP2102 devices
Message-ID: <20041119162255.607e9be2@lembas.zaitcev.lan>
In-Reply-To: <mailman.1100831940.24470.linux-kernel2news@redhat.com>
References: <mailman.1100831940.24470.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004 09:39:08 -0800, Greg KH <greg@kroah.com> wrote:

> If people are looking for a good usb to serial chip that is supported on
> Linux, Windows, and OS-X, there's the PL2303 device from Prolific, and
> the FTDI-SIO chip, and the MCT-U232 chip.  All of these work very well
> on Linux, and are fully supported by all distros.  I think they even
> might be cheaper than the CP2102 device too :)

The Magic Technology has ignored my requests to provide documentation for
either Intel or Phillips based version of their kit. The mct_u232 was
developed by reverse engineering the code, so it's probably not a good
example.

Why did you omit Keyspan? I thought they had reasonable policies, if we
ignore debian-legal issue for the moment.

-- Pete

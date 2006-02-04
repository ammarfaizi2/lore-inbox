Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbWBDXOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbWBDXOg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 18:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWBDXOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 18:14:35 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7948 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932578AbWBDXOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 18:14:35 -0500
Date: Sat, 4 Feb 2006 23:14:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       linux-fbdev-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: open bugzilla reports
Message-ID: <20060204231425.GA24887@flint.arm.linux.org.uk>
Mail-Followup-To: "Martin J. Bligh" <mbligh@mbligh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
	linux-fbdev-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
References: <20060203151150.3d9aa8b3.akpm@osdl.org> <20060204095023.GA11140@flint.arm.linux.org.uk> <20060204084729.defc7c19.mbligh@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060204084729.defc7c19.mbligh@mbligh.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2006 at 08:47:29AM -0800, Martin J. Bligh wrote:
> 
> > > [Bug 5958] CF bluetooth card oopses machine when
> > > 	http://bugzilla.kernel.org/show_bug.cgi?id=5958
> > 
> > This isn't a serial bug - it's a bluetooth ldisc bug.  I reported it
> > to the bluetooth folk back when it first got raised by Pavel.  However,
> > they seem to be completely disinterested in fixing it.
> > 
> > Unfortunately, there isn't a category for bt crap in bugzilla, otherwise
> > I'd reassign it.  Please kick the bt folk.
> 
> Stick it under Drivers/Other if you want ...

It _is_ under Networking/Other, yet akpm still thinks it's a serial
bug.  I'm not sure why though, I've fully explained why it isn't
a serial problem in the bug comments.

akpm is buggy and needs fixing.  Where do I file this bug? 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

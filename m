Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272294AbTG3WWw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272299AbTG3WWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:22:51 -0400
Received: from mcgroarty.net ([64.81.147.195]:33487 "EHLO pinkbits.internal")
	by vger.kernel.org with ESMTP id S272294AbTG3WWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:22:47 -0400
Date: Wed, 30 Jul 2003 17:22:26 -0500
To: Marc Giger <gigerstyle@gmx.ch>
Cc: Pavel Machek <pavel@suse.cz>, John Bradford <john@grabjohn.com>,
       linux-kernel@vger.kernel.org, pgw99@doc.ic.ac.uk
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030730222226.GA12981@mcgroarty.net>
References: <200307301608.h6UG8YQJ000339@81-2-122-30.bradfords.org.uk> <20030730174457.GI10276@atrey.karlin.mff.cuni.cz> <20030730205002.1e2a27bf.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730205002.1e2a27bf.gigerstyle@gmx.ch>
X-Debian-GNU-Linux: Rocks
From: Brian McGroarty <brian@mcgroarty.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 08:50:02PM +0200, Marc Giger wrote:
> 
> My personal goal would be to controll a Dot-Matrix Display. The
> Display should show something like the actual CPU temperature,
> CPU-load, processes, s.m.a.r.t state, etc etc etc etc..........But my
> problem is how to beginn with that. I would prefer to controll it with a
> PCI card. Also I looked today at 68HC11 microcontrollers, which I can
> connect to the serial port and transmit the needed infos.
> 
> Are there suggestions / comments / questions?
> 
> If somebody is interested to develop such a card / controller with me, I
> will be pleased to hear from you!

I don't know if you're more after having a project or having the end
result, but if you just want the hardware then the end result is
already available here:

http://www.crystalfontz.com/



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTFIVTa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTFIVTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:19:30 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:62672 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S262093AbTFIVT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:19:29 -0400
Date: Mon, 9 Jun 2003 23:32:47 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] New system device API
Message-ID: <20030609213247.GC508@elf.ucw.cz>
References: <20030609210706.GA508@elf.ucw.cz> <Pine.LNX.4.44.0306091412440.11379-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306091412440.11379-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > So? A keyboard controller is not classified as a system device.
> > 
> > Its not on pci, I guess it would end up as a system device...
> 
> Huh? Since when is everything that's not PCI a system device? Please read 
> the documentation, esp. WRT system and platform devices.

Oh and btw keyboard controller is used for rebooting machine. Do you
still say it is not system device?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

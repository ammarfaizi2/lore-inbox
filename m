Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbTEMSSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbTEMSSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:18:37 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:60056 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262287AbTEMSSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:18:34 -0400
Date: Tue, 13 May 2003 19:31:31 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Stian Jordet <liste@jordet.nu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 712] New: USB device not accepting new address.
Message-ID: <20030513183131.GA4543@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Stian Jordet <liste@jordet.nu>, LKML <linux-kernel@vger.kernel.org>
References: <24740000.1052833661@[10.10.2.4]> <1052842466.20418.0.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052842466.20418.0.camel@chevrolet.hybel>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 06:14:27PM +0200, Stian Jordet wrote:
 > > unplugging, and replugging the camera does this...
 > > 
 > > hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
 > > hub 1-0:0: new USB device on port 2, assigned address 4
 > > usb 1-2: USB device not accepting new address=4 (error=-110)
 > > hub 1-0:0: new USB device on port 2, assigned address 5
 > > usb 1-2: USB device not accepting new address=5 (error=-110)
 > > 
 > > This worked up until very recently. (Maybe even in 2.5.69)
 > 
 > ACPI enabled? If so, I bet it works without acpi.

You'd lose that bet. Didn't make any difference whatsoever.

		Dave

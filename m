Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbTEMSVA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbTEMSVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:21:00 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:36110 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S262293AbTEMSUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:20:25 -0400
Subject: Re: [Bug 712] New: USB device not accepting new address.
From: Stian Jordet <liste@jordet.nu>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030513183131.GA4543@suse.de>
References: <24740000.1052833661@[10.10.2.4]>
	 <1052842466.20418.0.camel@chevrolet.hybel>  <20030513183131.GA4543@suse.de>
Content-Type: text/plain
Message-Id: <1052850806.20418.5.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 13 May 2003 20:33:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 13.05.2003 kl. 20.31 skrev Dave Jones:
> On Tue, May 13, 2003 at 06:14:27PM +0200, Stian Jordet wrote:
>  > > unplugging, and replugging the camera does this...
>  > > 
>  > > hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
>  > > hub 1-0:0: new USB device on port 2, assigned address 4
>  > > usb 1-2: USB device not accepting new address=4 (error=-110)
>  > > hub 1-0:0: new USB device on port 2, assigned address 5
>  > > usb 1-2: USB device not accepting new address=5 (error=-110)
>  > > 
>  > > This worked up until very recently. (Maybe even in 2.5.69)
>  > 
>  > ACPI enabled? If so, I bet it works without acpi.
> 
> You'd lose that bet. Didn't make any difference whatsoever.

Gee. Not my day. Sorry about the noise :(

Best regards,
Stian


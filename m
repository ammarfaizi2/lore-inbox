Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbVHGLjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbVHGLjI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 07:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbVHGLjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 07:39:08 -0400
Received: from rly-ip03.mx.aol.com ([64.12.138.7]:4309 "EHLO
	rly-ip03.mx.aol.com") by vger.kernel.org with ESMTP
	id S1751473AbVHGLjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 07:39:07 -0400
Subject: Re: Logitech Quickcam Express USB Address Aquisition Issues
From: christos gentsis <christos_gentsis@yahoo.co.uk>
To: Chris White <chriswhite@gentoo.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050807160222.0c4ee412@localhost>
References: <20050807160222.0c4ee412@localhost>
Content-Type: text/plain
Date: Sun, 07 Aug 2005 12:36:40 +0100
Message-Id: <1123414600.14724.3.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-AOL-IP: 195.93.24.101
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-07 at 16:02 +0900, Chris White wrote:
> [Pre Note: please CC me all responses, thanks]
> 
> Currently, I have a Logitech Quickcam Express webcamera.  Unfortunately, it seems to have issues getting assigned an address.  I quote the following from dmesg:
> 
> usb 1-1.1: new full speed USB device using ehci_hcd and address 11
> usb 1-1.1: device descriptor read/64, error -32
> usb 1-1.1: device descriptor read/64, error -32
> usb 1-1.1: new full speed USB device using ehci_hcd and address 12
> usb 1-1.1: device descriptor read/64, error -32
> usb 1-1.1: device descriptor read/64, error -32
> usb 1-1.1: new full speed USB device using ehci_hcd and address 13
> usb 1-1.1: device not accepting address 13, error -32
> usb 1-1.1: new full speed USB device using ehci_hcd and address 14
> usb 1-1.1: device not accepting address 14, error -32
> 
> As far as the host goes, I have the following USB hosts:
> 
> 0000:00:11.0 USB Controller: NEC Corporation USB (rev 43)
> 0000:00:11.1 USB Controller: NEC Corporation USB (rev 43)
> 0000:00:11.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
> 
> The first is my builtin Intel USB controller, the second is one belkin USB 1.0 card, and another 2.0 card.  I've tried it in all three just to verify one of my hosts wasn't broken.  Considering my printer works with it, as well as my scanner, I'm sort of thinking that's not an issue.
> 
> I searched up google a bit and recieved some warnings about acpi causing problems, so I disabled that, but was still unsucessful in getting that to work.  Please let me know if any other information is required.  Thanks ahead of time.
> 
> Chris White

does the drivers for the Phillips web cams come back to the kernel?
because i thought that it was taken out... 

http://www.smcc.demon.nl/webcam/

check this site and see if your cam was one of the cams that supported
from the driver that discontinue... so if is supported by this driver,
download and install it... it works i try it with my cam ;)



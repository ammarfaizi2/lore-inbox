Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752659AbVHGT4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbVHGT4J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 15:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752660AbVHGT4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 15:56:09 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:39839 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752659AbVHGT4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 15:56:08 -0400
Subject: Re: Wireless support
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1123442554.12766.17.camel@mindpipe>
References: <1123442554.12766.17.camel@mindpipe>
Content-Type: text/plain
Date: Sun, 07 Aug 2005 15:56:06 -0400
Message-Id: <1123444566.12766.23.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-07 at 15:22 -0400, Lee Revell wrote:
> Is the Linksys WUSB 54GS wireless adapter (FCCID Q87-WUSB54GS)
> supported?
> 

Wow, Google has really declined in quality.  I got zero hits for
"Linksys WUSB 54G linux".  Then I found this page on my own.

(from http://ndiswrapper.sourceforge.net/mediawiki/index.php/List)

Card: Linksys #[WUSB54G], 802.11b/g, USB 2.0 -- [link here|List#WUSB54G] 
      * Chipset: Prism54
      * usbid: 5041:2234
      * Driver: Linksys Windows XP driver
        http://www.linksys.com/download/default.asp
      * Other: Works smoothly, of course ;) - this is the device the USB
        extension was originally developed for. WEP is running, WPA is
        supported using wpa_supplicant 0.2.5. No problems with both 1.1
        and 2.0 host controllers. As with many other USB devices, no
        success with 2.4 kernels so far. Try to use 2.6.7 or better.
        There is a native driver for Prism54 that is working on USB
        support. View its status at Prism54.org

Sorry for the WOB.  And if anyone from Google is reading, WTF?

Lee


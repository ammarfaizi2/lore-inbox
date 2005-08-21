Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVHUCRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVHUCRy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 22:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVHUCRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 22:17:54 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:38797 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1750763AbVHUCRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 22:17:53 -0400
Date: Sun, 21 Aug 2005 04:17:16 +0200
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: Problems with connect/disconnect cycles
Message-ID: <20050821021716.GA523@gamma.logic.tuwien.ac.at>
References: <20050821013257.GA31597@gamma.logic.tuwien.ac.at> <Pine.LNX.4.44L0.0508202151130.1374-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L0.0508202151130.1374-100000@netrider.rowland.org>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sam, 20 Aug 2005, Alan Stern wrote:
> Speaking in broad terms, it's normal to see new device connection and
> configuration messages like the ones above when a USB device is plugged in
> to your computer.  What's not normal is to see disconnects.  So you should

Mind that this is an *internal* builtin card reader on my laptop. I will
go through the log files and look if I find patterns.

> why is the card reader disconnecting?  Turning on CONFIG_USB_DEBUG may 

ok.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining AT logic DOT at>             Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
AASLEAGH (n.)
A liqueur made only for drinking at the end of a revoltingly long
bottle party when all the drinkable drink has been drunk.
			--- Douglas Adams, The Meaning of Liff

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSIEIh1>; Thu, 5 Sep 2002 04:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSIEIhV>; Thu, 5 Sep 2002 04:37:21 -0400
Received: from hera.cwi.nl ([192.16.191.8]:45816 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S317326AbSIEIhT>;
	Thu, 5 Sep 2002 04:37:19 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 5 Sep 2002 10:41:48 +0200 (MEST)
Message-Id: <UTC200209050841.g858fmZ28242.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, alaric@babcom.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Feiya 5-in-1 Card Reader
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Speaking of sddr09 devices (of which I possess one), what's the current
> state of support for the sddr09?  Last I knew, at the time when I finally
> got mine working, the sddr09 was only supported read-only

For me it works read-write and out-of-the-box on a vanilla kernel.
(I added this stuff a few months ago. Found in 2.5 (which I use).
Am not quite sure about 2.4.)

Andries


[In case you try 2.5, a warning: later tens and early twenties
will eat filesystems if you have the wrong IDE hardware. But
2.5.32, 2.5.33 are fine here.]

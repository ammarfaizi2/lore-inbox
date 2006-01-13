Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161171AbWAMKaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbWAMKaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161549AbWAMKaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:30:06 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:61624 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161171AbWAMKaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:30:02 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [PATCH 00/13] USBATM: summary
Date: Fri, 13 Jan 2006 11:30:04 +0100
User-Agent: KMail/1.9.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       usbatm@lists.infradead.org
References: <200601121729.52596.baldrick@free.fr> <20060112183001.GA23777@kroah.com>
In-Reply-To: <20060112183001.GA23777@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601131130.04762.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I only got 2 of these, is my mail just being slow (which it does at odd
> times), or did you stop sending them based on some problems on your end?

Hi Greg, I stopped because I noticed that part of patch 2 had slipped
into patch 3 (the bit that slipped was exactly the tweak I made to patch 2
to have it compile by itself... probably ended up in patch 3 due to a
forgotten "quilt refresh"), and I wanted to check all the other patches.
They are fine, so I have now sent them.  However, patch 2 won't compile
unless you apply patch 3 as well. Since they are both trivial, I hope you
are ok with that, otherwise I can rediff them

All the best,

Duncan.

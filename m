Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWFWAFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWFWAFQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 20:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWFWAFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 20:05:16 -0400
Received: from gw.goop.org ([64.81.55.164]:14220 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751637AbWFWAFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 20:05:15 -0400
Message-ID: <449B3047.50704@goop.org>
Date: Thu, 22 Jun 2006 17:05:27 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.17
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606221546120.6483@g5.osdl.org> <20060622234040.GB30143@suse.de>
In-Reply-To: <20060622234040.GB30143@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> I saw this once when debugging the usb code, but could never reproduce
> it, so I attributed it to an incomplete build at the time, as a reboot
> fixed it.
>
> Is this easy to trigger for you?
>   

This is the same oops as I posted yesterday: "2.6.17-mm1: oops in 
Bluetooth stuff, usbdev_open".  I haven't seen it since...

    J

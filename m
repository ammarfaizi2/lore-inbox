Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932728AbWFVXst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbWFVXst (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbWFVXst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:48:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61129 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932707AbWFVXss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:48:48 -0400
Date: Thu, 22 Jun 2006 16:48:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.17
In-Reply-To: <20060622234040.GB30143@suse.de>
Message-ID: <Pine.LNX.4.64.0606221646200.6483@g5.osdl.org>
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606221546120.6483@g5.osdl.org>
 <20060622234040.GB30143@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jun 2006, Greg KH wrote:
>
> I saw this once when debugging the usb code, but could never reproduce
> it, so I attributed it to an incomplete build at the time, as a reboot
> fixed it.

I'm pretty sure the build was good, but it may well be timing-related.

> Is this easy to trigger for you?

No. I've never seen it before on this machine (and it's that Mac Mini that 
I've been rebooting several times a day for the last week), so if it's an 
old bug, it's definitely not repeatable. I was thinking it would be 
something new..

I'll let you know if I can repro it.

		Linus

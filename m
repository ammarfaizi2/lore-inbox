Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759775AbWLCW1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759775AbWLCW1U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 17:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759779AbWLCW1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 17:27:20 -0500
Received: from twin.jikos.cz ([213.151.79.26]:58602 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1759775AbWLCW1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 17:27:19 -0500
Date: Sun, 3 Dec 2006 23:21:39 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [GIT PATCH] USB patches for 2.6.19
In-Reply-To: <1165151160.19590.2.camel@localhost>
Message-ID: <Pine.LNX.4.64.0612032320470.28502@twin.jikos.cz>
References: <Pine.LNX.4.44L0.0612021555530.20254-100000@netrider.rowland.org>
 <1165151160.19590.2.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2006, Marcel Holtmann wrote:

> about the USBHID part. Jiri Kosina is just about to finally split the 
> HID parser and make it available for Bluetooth and USB as an independent 
> subsystem. This might conflict with any autosuspend changes for the 
> USBHID. It might be better that this waits until Jiri's patches are 
> merged.

Yup, thanks, I think so.

Just for the record - I am planning to push these patches just after 
2.6.20-rc1 either to Andrew or Greg.

Thanks,

-- 
Jiri Kosina

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425362AbWLHK7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425362AbWLHK7k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 05:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425361AbWLHK7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 05:59:40 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:58094 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425356AbWLHK7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 05:59:39 -0500
Subject: Re: [git pull] Input patches for 2.6.19
From: Marcel Holtmann <marcel@holtmann.org>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dtor@insightbb.com>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <Pine.LNX.4.64.0612081038520.1665@twin.jikos.cz>
References: <200612080157.04822.dtor@insightbb.com>
	 <Pine.LNX.4.64.0612081038520.1665@twin.jikos.cz>
Content-Type: text/plain
Date: Fri, 08 Dec 2006 12:59:44 +0100
Message-Id: <1165579184.5529.33.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

> >  b/drivers/usb/input/hid-core.c                 |    7 
> >  b/drivers/usb/input/hid-input.c                |    4 
> >  b/drivers/usb/input/hid.h                      |    1 
> 
> OK, this is going to break the merge from Greg's tree of generic HID 
> layer, which was planned for today.
> 
> The merge will probably emit a large .rej files, due to the large blocks 
> of code being moved around, but it seems that most of the changes which 
> would conflict with the merge could be trivially solved by hand.
> 
> Greg, should I prepare a new version of the generic HID patches against 
> merged Linus' + Dmitry's trees and send them to you?

yes please, because Linus already merged Dmitry's patches.

Regards

Marcel



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbULZLVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbULZLVN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 06:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbULZLVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 06:21:13 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:42217 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261632AbULZLVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 06:21:10 -0500
Subject: Re: [2.6 patch] net/bluetooth/: misc possible cleanups
From: Marcel Holtmann <marcel@holtmann.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Max Krasnyansky <maxk@qualcomm.com>, bluez-devel@lists.sf.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Network Development Mailing List <netdev@oss.sgi.com>
In-Reply-To: <20041219160758.GY21288@stusta.de>
References: <20041214041352.GZ23151@stusta.de>
	 <1103009649.2143.65.camel@pegasus>  <20041219160758.GY21288@stusta.de>
Content-Type: text/plain
Date: Sun, 26 Dec 2004 12:20:18 +0100
Message-Id: <1104060018.8758.51.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> > > Please comment on which of these changes are correct and which conflict 
> > > with pending patches.
> > 
> > Please send a separate patch for all the RFCOMM changes, because these
> > conflicts with some pending patches and then it will make it easier for
> > me to merge them.
> > 
> > The rest of the changes are fine with me, but I like to see also a
> > separate patch for the CMTP stuff and cmtp_send_capimsg() don't need a
> > forward declaration. Simply move the function to another place in the
> > source code.
> 
> splitted patches follow as reply to this email.

all of them are applied to my tree now. Thanks.

Regards

Marcel



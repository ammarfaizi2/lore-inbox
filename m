Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbULTEwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbULTEwX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 23:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbULTEwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 23:52:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24705 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261420AbULTEwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 23:52:21 -0500
Date: Sun, 19 Dec 2004 20:51:04 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg KH <greg@kroah.com>, mdharm-usb@one-eyed-alien.net,
       zaitcev@redhat.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
Message-ID: <20041219205104.5054a156@lembas.zaitcev.lan>
In-Reply-To: <20041220013542.GK21288@stusta.de>
References: <20041220001644.GI21288@stusta.de>
	<20041220003146.GB11358@kroah.com>
	<20041220013542.GK21288@stusta.de>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004 02:35:42 +0100, Adrian Bunk <bunk@stusta.de> wrote:

> What about a dependency of BLK_DEV_UB on USB_STORAGE=n ?

I have them both as 'm' in my configuration, works like a charm.

-- Pete

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265706AbUFSNsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265706AbUFSNsZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 09:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265722AbUFSNsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 09:48:25 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:20899 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S265706AbUFSNsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 09:48:24 -0400
From: Duncan Sands <baldrick@free.fr>
To: Ian Morgan <imorgan@webcon.ca>
Subject: Re: [linux-usb-devel] Re: USBDEVFS_RESET deadlocks USB bus.
Date: Sat, 19 Jun 2004 15:48:21 +0200
User-Agent: KMail/1.6.2
Cc: linux-usb-devel@lists.sourceforge.net,
       "Zephaniah E. Hull" <warp@mercury.d2dc.net>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David A. Desrosiers" <desrod@gnu-designs.com>
References: <20040604193911.GA3261@babylon.d2dc.net> <200406082219.41213.baldrick@free.fr> <Pine.LNX.4.60.0406181529370.4796@light.int.webcon.net>
In-Reply-To: <Pine.LNX.4.60.0406181529370.4796@light.int.webcon.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406191548.21989.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know for sure that the problem I'm having is related, but it sure
> sound like it:

Hi Ian, I was talking about the problem in usbfs where only one bulk or
control message can be in flight at any one time.  Your problem seems
quite different to this, sorry!

All the best,

Duncan.

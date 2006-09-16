Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWIPXDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWIPXDi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 19:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWIPXDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 19:03:37 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:12780 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964832AbWIPXDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 19:03:36 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: 2.6.18-rc6-mm2: rmmod ohci_hcd oopses on HPC 6325
Date: Sun, 17 Sep 2006 01:02:23 +0200
User-Agent: KMail/1.9.1
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       david-b@pacbell.net
References: <200609131558.03391.rjw@sisk.pl> <200609141319.53942.rjw@sisk.pl> <20060915154515.ae14372c.zaitcev@redhat.com>
In-Reply-To: <20060915154515.ae14372c.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609170102.24425.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 16 September 2006 00:45, Pete Zaitcev wrote:
> On Thu, 14 Sep 2006 13:19:53 +0200, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > In fact I can reproduce it on two different boxes now.
> 
> How about the attached?

Apparently works. :-)

Thanks,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbTDKWYs (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTDKWYs (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:24:48 -0400
Received: from fmr02.intel.com ([192.55.52.25]:33228 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S261886AbTDKWYr convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 18:24:47 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBAAB2@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'oliver@neukum.name'" <oliver@neukum.name>, "'Greg KH'" <greg@kroah.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-hotplug-devel@lists.sourceforge.net'" 
	<linux-hotplug-devel@lists.sourceforge.net>,
       "'message-bus-list@redhat.com'" <message-bus-list@redhat.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>
Subject: RE: [ANNOUNCE] udev 0.1 release
Date: Fri, 11 Apr 2003 15:36:15 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Oliver Neukum [mailto:oliver@neukum.org]
>
> > Ok, if you are worried about these kinds of things, then use the
> > in-kernel devfs.  I'm not going to dispute that userspace faults can
> > happen.
> 
> Yes, in my oppinion putting such things into user space is stupid.
> Your considerable talents would be better used to help Adam getting
> his simplified devfs ready.

Fixating naming policy in the kernel goes along the lines too; 
unless kdevfs gets the ability to be policy-configurable, it is no use.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)

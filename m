Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbTDLHmf (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 03:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTDLHmf (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 03:42:35 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:17342 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263184AbTDLHme (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 03:42:34 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Greg KH'" <greg@kroah.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
Date: Sat, 12 Apr 2003 09:53:41 +0200
User-Agent: KMail/1.5
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-hotplug-devel@lists.sourceforge.net'" 
	<linux-hotplug-devel@lists.sourceforge.net>,
       "'message-bus-list@redhat.com'" <message-bus-list@redhat.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>
References: <A46BBDB345A7D5118EC90002A5072C780BEBAAB2@orsmsx116.jf.intel.com>
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780BEBAAB2@orsmsx116.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304120953.41769.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 12. April 2003 00:36 schrieb Perez-Gonzalez, Inaky:
> > From: Oliver Neukum [mailto:oliver@neukum.org]
> >
> > > Ok, if you are worried about these kinds of things, then use the
> > > in-kernel devfs.  I'm not going to dispute that userspace faults can
> > > happen.
> >
> > Yes, in my oppinion putting such things into user space is stupid.
> > Your considerable talents would be better used to help Adam getting
> > his simplified devfs ready.
>
> Fixating naming policy in the kernel goes along the lines too;
> unless kdevfs gets the ability to be policy-configurable, it is no use.

Why? Who cares about names? IMHO that's useless frill.
If he absolutely cannot stand the kernel default, use a symlink.
You do not protest against numbering policy in the kernel,
why are names worse?

	Regards
		Oliver


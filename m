Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUHPKml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUHPKml (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbUHPKmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:42:40 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:58046 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267528AbUHPKmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:42:31 -0400
Date: Mon, 16 Aug 2004 11:42:00 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Keith Whitwell <keith@tungstengraphics.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: DRM and 2.4 ...
In-Reply-To: <20040816101426.GB31696@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0408161137330.21177@skynet>
References: <Pine.LNX.4.58.0408160652350.9944@skynet>
 <1092640312.2791.6.camel@laptop.fenrus.com> <412081C6.20601@tungstengraphics.com>
 <20040816094622.GA31696@devserv.devel.redhat.com> <412088A5.6010106@tungstengraphics.com>
 <20040816101426.GB31696@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> DRM_IOCTL_ARGS, DRM_ERR, DRM_CURRENTPID, DRM_UDELAY, DRM_READMEMORYBARRIER,
> DRM_COPY_FROM_USER_IOCTL etc etc existed prior to freebsd support? Oh my
> god...

I'm currently open for constructive critics with ideas on how to fix these
things, the DRM is open for business if we can fix things up now it will
be a lot easier while I'm knee deep with time than after I'm finished and
back travelling .. should we have try to implement Linux fns in BSD, what
do we do if more parameters/info are needed from a BSD side, or do we try
and sideline all these into a separate library of functions and wrap them
on both bsd and linux?

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person


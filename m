Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268145AbUJJHAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268145AbUJJHAx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 03:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268149AbUJJHAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 03:00:53 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:4027 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S268145AbUJJHAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 03:00:51 -0400
Date: Sun, 10 Oct 2004 08:00:50 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Greg KH <greg@kroah.com>, Jon Smirl <jonsmirl@gmail.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [patch] drm core internal versioning..
In-Reply-To: <1097390654.2788.6.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.58.0410100759280.18789@skynet>
References: <Pine.LNX.4.58.0410100050160.6083@skynet> 
 <9e47339104100917527993026d@mail.gmail.com>  <Pine.LNX.4.58.0410100328080.11219@skynet>
  <20041010042958.GA28025@kroah.com>  <Pine.LNX.4.58.0410100625220.12189@skynet>
 <1097390654.2788.6.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> The versioning we all talk about doesn't use MODVERSIONS but the
> VERSIONMAGIC stuff, that is ALWAYS in use.

No I'm actually talking about both :-)

VERSIONMAGIC stops the using binary modules and now that I think off it,
I'm not sure what great use MODVERSIONS have anymore if you can't load a
module into a different kernel version...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person


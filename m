Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270050AbUIDEwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270050AbUIDEwk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 00:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270051AbUIDEwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 00:52:40 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:58337 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S270050AbUIDEwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 00:52:38 -0400
Date: Sat, 4 Sep 2004 05:52:37 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, dri-devel@lists.sf.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
In-Reply-To: <9e4733910409032051717b28c0@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0409040548490.25475@skynet>
References: <Pine.LNX.4.58.0409040107190.18417@skynet> 
 <a728f9f904090317547ca21c15@mail.gmail.com>  <Pine.LNX.4.58.0409040158400.25475@skynet>
 <9e4733910409032051717b28c0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think we have to remember licensing at all stages of this, the DRM is
X licensed, so I don't think we can just merge the fb code, I'm not sure
what peoples views on this, the main reason I see for using X licensing
is that we can share this stuff with FreeBSD and have an open source
graphics interface standard that the chipset designers can use, against it
is the fact that it allows for properitary drivers, - I personally don't
think we'll ever win that war.. will the prop drivers be derived works of
the DRM rather than the kernel anyone got a spare lawyer?

Dave.

On Fri, 3 Sep 2004, Jon Smirl wrote:

> As we work towards the merged DRM/fbdev goal the fbdev libraries are
> going to become part of DRM. The libraries will be used pretty much
> unchanged as it is the driver code that needs to be adjusted. How does
> this play with the new DRM model?
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person


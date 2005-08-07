Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVHGBNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVHGBNm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 21:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVHGBMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 21:12:14 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:19928 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261402AbVHGBK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 21:10:56 -0400
Date: Sun, 7 Aug 2005 02:10:54 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Lee Revell <rlrevell@joe-job.com>
Cc: Joris van Rantwijk <jvrantwijk@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: DRM VIA driver on Unichrome Pro K8M800
In-Reply-To: <1123376611.17039.1.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0508070209280.30320@skynet>
References: <fa.f66affe.52avgq@ifi.uio.no>  <20050806192647.GA11937@xs4all.nl>
  <1123366850.14113.18.camel@mindpipe> <1123376611.17039.1.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > FWIW, this is working great with my CLE266 chipset.
>
> Actually I take this back.  The xscreensaver demos all work but I tried
> ppracer and the course looks OK but Tux is invisible.

that's a secret feature to get him past closed source drivers ;-)

on the other hand I've no idea what might be wrong.. but my guess would be
the userspace Mesa driver not the DRM.... ask on dri-devel or logs a bug
on bugs.freedesktop.org

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG


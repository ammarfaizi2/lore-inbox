Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVCOKci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVCOKci (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 05:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVCOKci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 05:32:38 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:49587 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261678AbVCOKcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 05:32:36 -0500
Date: Tue, 15 Mar 2005 10:32:35 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       adaplas@pol.net
Subject: Re: nvidia fb licensing issue.
In-Reply-To: <9e47339105031318038d74da9@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0503151028160.22756@skynet>
References: <20050313042459.GF32494@redhat.com>  <20050312215936.513039a6.akpm@osdl.org>
  <1110701914.6278.18.camel@laptopd505.fenrus.org> <9e47339105031318038d74da9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 13 Mar 2005, Jon Smirl wrote:

> All of the files in drivers/char/drm really should have an explicit
> dual MIT/GPL license on them too. The DRM project has been taking
> patches back into DRM from LKML without making it clear that DRM is
> MIT licensed. It might be construed that doing this has made DRM GPL
> without that being the intention.

They all have explicit MIT licenses on them, these files are only
dual-licensed by the fact that they are shipped with the kernel, but they
are MIT licensed and I would consider any changes to them to be MIT
licensed unless someone explicitly states it..

Similiar to the reiser notice on top of those files.. I think MIT license
is explicit enough...

Some files are GPL licensed like drm_sysfs as it is obivously derived from
GPL code,

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG


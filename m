Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUIDWGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUIDWGM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 18:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUIDWGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 18:06:12 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:42471 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S263117AbUIDWGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 18:06:06 -0400
Date: Sat, 4 Sep 2004 23:06:05 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Lee Revell <rlrevell@joe-job.com>
Cc: Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: New proposed DRM interface design
In-Reply-To: <1094333738.6575.393.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.58.0409042304200.24528@skynet>
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> 
 <Pine.LNX.4.58.0409040145240.25475@skynet>  <20040904102914.B13149@infradead.org>
  <41398EBD.2040900@tungstengraphics.com>  <20040904104834.B13362@infradead.org>
  <413997A7.9060406@tungstengraphics.com>  <20040904112535.A13750@infradead.org>
  <4139995E.5030505@tungstengraphics.com>  <20040904120352.B14037@infradead.org>
  <Pine.LNX.4.58.0409041207060.25475@skynet>  <20040904114243.GC2785@redhat.com>
 <1094333738.6575.393.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> How about getting the VIA DRI module into the kernel?

As soon as it is secure it goes in, the VIA DRI developers are working on
it at the moment, and it should be suitable for merging soon...

we also have out of kernel DRM drivers for mach64 and savage that would
pose security issues if shipped, so we can't develop them in-kernel....
(another reason for the CVS tree)...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267686AbUIDLe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUIDLe1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269903AbUIDLbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:31:53 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:53431 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S269893AbUIDLal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:30:41 -0400
Message-ID: <4139A759.7040503@tungstengraphics.com>
Date: Sat, 04 Sep 2004 12:30:33 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <20040904120352.B14037@infradead.org> <4139A480.4060306@tungstengraphics.com> <20040904122044.A14310@infradead.org>
In-Reply-To: <20040904122044.A14310@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sat, Sep 04, 2004 at 12:18:24PM +0100, Keith Whitwell wrote:
> 
>>You didn't stick with that long Christoph.  We're not even past first base 
>>yet.  Let's try again?
>>
>>So, I've got this file "patch-2.6.8.1.bz2".  Lets suppose my older brother 
>>comes in & compiles it up for me & I'm now running 2.6.8.1 - it's implausible 
>>I know, but let's make it easier for you.  Now, why isn't my i915 working?
> 
> 
> Because the drm developer took a long time to submit the driver after
> is was finished as they develop in a separate CVS tree instead of the kernel
> tree.

OK, fair enough.  We've been spoilt in the past with "automatic" merges 
courtesy of some nice LKML types.

But, now I've compiled 2.6.9 or whatever, it's still not working.  My brother 
says he won't come in and do any more work on my computer, so you'll have to 
help me out from here...

Keith

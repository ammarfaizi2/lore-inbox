Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269877AbUIDKbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269877AbUIDKbD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 06:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269876AbUIDKbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 06:31:03 -0400
Received: from colossus.systems.pipex.net ([62.241.160.73]:50906 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S269875AbUIDKa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 06:30:59 -0400
Message-ID: <4139995E.5030505@tungstengraphics.com>
Date: Sat, 04 Sep 2004 11:30:54 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org>
In-Reply-To: <20040904112535.A13750@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sat, Sep 04, 2004 at 11:23:35AM +0100, Keith Whitwell wrote:
> 
>>>Actually regulat users do.  And they do by pulling an uptodate kernel or
>>>using a vendor kernel with backports.  This model would work for video drivers
>>>aswell.
>>
>>Sure, explain to me how I should upgrade my RH-9 system to work on my new i915?
> 
> 
> Download a new kernel.org kernel or petition the fedora legacy folks to
> include a drm update.  The last release RH-9 kernel has various security
> and data integrity issues anyway, so you'd be a fool to keep running it.

OK, I've found www.kernel.org, and clicked on the 'latest stable kernel' link. 
  I got a file called "patch-2.6.8.1.bz2".  I tried to install this but 
nothing happened.  My i915 still doesn't work.  What do I do now?

Keith

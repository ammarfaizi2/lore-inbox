Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269704AbUICSzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269704AbUICSzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269456AbUICSzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:55:17 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:11228 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269738AbUICSrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:47:04 -0400
Message-ID: <4138BC13.2080005@us.ibm.com>
Date: Fri, 03 Sep 2004 11:46:43 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [BK pull] DRM macro removal tree
References: <Pine.LNX.4.58.0409031134290.32026@skynet> <Pine.LNX.4.58.0409031100130.26393@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409031100130.26393@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Fri, 3 Sep 2004, Dave Airlie wrote:
> 
>>This isn't the standard drm-2.6 tree, it is a separate tree for feeding
>>the macro removal function table stuff. The highlights of this tree are:
> 
> Hey, looks much cleaner, but I just wanted to check that this is all stuff
> that has been agreed upon in the DRM groups? I don't follow the DRM
> mailing list actively any more..

Yes, it is.  The general consensus is that all the other DRM / DRI 
developers are glad Dave is doing this work...so that we don't have to. :)

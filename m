Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266784AbUGVAW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266784AbUGVAW4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 20:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUGVAWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 20:22:55 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:1422 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S266784AbUGVAWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 20:22:42 -0400
Message-ID: <40FF0885.7060704@tlinx.org>
Date: Wed, 21 Jul 2004 17:21:25 -0700
From: L A Walsh <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: 2.6.7-vanilla-SMP kernel: pagebuf_get: failed to lookup pages
References: <40FF0479.6050509@tlinx.org> <20040722001224.GC30595@taniwha.stupidest.org>
In-Reply-To: <20040722001224.GC30595@taniwha.stupidest.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will this be included/fixed in 2.6.8?

How serious is the problem?  The system doesn't seem to panic or 
indicate backup
failures.

Setting up a CVS tree to get a patch for a "stable-series" kernel seems 
a bit
unstable.  I'm not sure what I'd pull in besides the fix or even if I'd pull
down a coherent/stable CVS image if I downloaded in the middle of when some
other patch was being checked in.  Maybe I'm sounding like a wimp, but 
the idea
of pulling in freshly checked in CVS code for use on a 'stable' machine is
bordering on my discomfort zone. :-)

-l

Chris Wedgwood wrote:

>On Wed, Jul 21, 2004 at 05:04:09PM -0700, L A Walsh wrote:
>
>  
>
>>Any idea what this message means?
>>    
>>
>
>it means "try the CVS tree" (i think hch fixed this and it's in CVS
>but not mainline)
>
>
>  --cw
>  
>

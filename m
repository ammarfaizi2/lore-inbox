Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267386AbUJIUnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267386AbUJIUnZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUJIUlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:41:32 -0400
Received: from 1-1-8-31a.gmt.gbg.bostream.se ([82.182.75.118]:16621 "EHLO
	mail.shipmail.org") by vger.kernel.org with ESMTP id S267410AbUJIUkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:40:24 -0400
Message-ID: <41684CA6.3020201@shipmail.org>
Date: Sat, 09 Oct 2004 22:40:06 +0200
From: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <unichrome@shipmail.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6)
 Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Airlie <airlied@linux.ie>
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
Subject: Re: [rfc] VIA drm patch and bk tree for inclusion in
 kernel..
References: <Pine.LNX.4.58.0410091447170.25574@skynet>
In-Reply-To: <Pine.LNX.4.58.0410091447170.25574@skynet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-BitDefender-Spam: No (0)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dave Airlie wrote:

>Hi,
>       Okay the VIA DRM people have asked to include it in the kernel, it
>only allows accelerated XvMC for non-root users, and 3d for root users
>(the 3d paths are still not secure)...
>
>The bk tree at
>
>bk://drm.bkbits.net/drm-via
>
>the patch against Linus latest (along with some cleanup patches...)
>
>is at (it is quite big...)
>
>http://www.skynet.ie/~airlied/patches/dri/via_unichrome_patch.diff
>
>Can VIA people test this tree for me? either use bk or grab Linus latest
>and apply the patch...
>
>  
>
Works as expected with Linus latest.

/Thomas


>Dave.
>
>  
>



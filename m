Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTEHWyS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbTEHWyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:54:18 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:26893 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S262228AbTEHWyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:54:16 -0400
Message-ID: <3EBAE2D8.5070900@snapgear.com>
Date: Fri, 09 May 2003 09:06:00 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.69-uc1 (MMU-less fix ups)
References: <3F06CF6E.7090803@snapgear.com> <20030508153900.B9081@infradead.org>
In-Reply-To: <20030508153900.B9081@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Christoph Hellwig wrote:
> On Sat, Jul 05, 2003 at 11:15:26PM +1000, Greg Ungerer wrote:
> 
>>Hi All,
>>
>>Another update of the uClinux (MMU-less) fixups against 2.5.69.
>>This includes some of the missing m5282 CPU support, and fixes
>>gettimeofday() to be microsecond accurate.
>>
>>You can get it at:
> 
> 
> Any plans to submit patches to Linus so we'll have na updatodate
> m68knommu in mainline again?

Yes. I will submit all of these today.

I have sent several of these to Linus several times
over the last month... Just haven't shown up in the
mainline yet.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude          EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUASXvb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 18:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbUASXvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 18:51:31 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:52241 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S264522AbUASXv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:51:27 -0500
Message-ID: <400C6DB2.70403@snapgear.com>
Date: Tue, 20 Jan 2004 09:52:18 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.6.1-uc0 (MMU-less fix ups)
References: <400BD910.2000608@snapgear.com> <20040119162459.GP1748@srv-lnx2600.matchmail.com>
In-Reply-To: <20040119162459.GP1748@srv-lnx2600.matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Mike Fedyk wrote:
> On Mon, Jan 19, 2004 at 11:18:08PM +1000, Greg Ungerer wrote:
>>An update of the uClinux (MMU-less) fixups against linux-2.6.1.
>>Quite a few small fixes here, mostly carried forward from previous
>>patch sets. One important new fix to the page_alloc code for MMUless
>>systems.
> 
> Have you submitted any of these to Andrew?

Yes. I sent quite a few about a week ago.
I will send some more over the next few days.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com


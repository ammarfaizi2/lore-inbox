Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267593AbUBTAKA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267594AbUBTAKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:10:00 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:10765 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S267593AbUBTAJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:09:58 -0500
Message-ID: <40355080.8090008@snapgear.com>
Date: Fri, 20 Feb 2004 10:10:40 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.6.3-uc0 (MMU-less fixups)
References: <40342BD5.9080105@snapgear.com> <20040219103900.GH17140@khan.acc.umu.se> <4034B2E5.1090505@snapgear.com> <20040219131317.GI17140@khan.acc.umu.se>
In-Reply-To: <20040219131317.GI17140@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Weinehall wrote:
> On Thu, Feb 19, 2004 at 10:58:13PM +1000, Greg Ungerer wrote:
>>David Weinehall wrote:
>>>On Thu, Feb 19, 2004 at 01:21:57PM +1000, Greg Ungerer wrote:
>>>
>>>>An update of the uClinux (MMU-less) fixups against 2.6.3.
>>>>Nothing much new, just redone against 2.6.3.
>>>>
>>>>http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.3-uc0.patch.gz
>>>
>>>Any plans for a 2.6-version of the ARM-support?
>>
>>Yes. There is some code available now, although it is not complete
>>and doesn't fully work yet. It really needs more cleaning up before
>>it will be interresting or useful to anyone.
> 
> Dang.  I wish I still had some arm-hardware to play with (no, I'm not
> gonna sacrifice my Tungsten E for uClinux-work...)

You don't need real hardware :-)

The gdb/ARMulator makes a fine target for development.
Quicker and easier to develop with. Heres a good place
to get started with it if interrested:

   http://www.uclinux.org/pub/uClinux/utilities/armulator/


> How's the status of the 2.0-port of uClinux, btw?  Is it unintrusive
> enough to be considered for a 2.0-merge?

Hmm, probably not. It is no where near as clean as the 2.6
merge. It could be cleaned up, but no one seems to interrested
in doing the work.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSHBPVw>; Fri, 2 Aug 2002 11:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSHBPVw>; Fri, 2 Aug 2002 11:21:52 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:31998 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S315200AbSHBPVv>; Fri, 2 Aug 2002 11:21:51 -0400
Message-ID: <3D4AA573.3000705@snapgear.com>
Date: Sat, 03 Aug 2002 01:29:55 +1000
From: gerg <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.5.30uc0 MMU-less patches
References: <3D4A27FE.8030801@snapgear.com> <20020802141652.E25761@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Dave Jones wrote:
> On Fri, Aug 02, 2002 at 04:34:38PM +1000, Greg Ungerer wrote:
>  > I have a new set of uClinux (MMU-less) patches for 2.5.30 at:
>  > 
>  >    http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/
> 
> One thing really puzzles me.
> Why is there SGI VisWS, X86-foo, ACPI and god-knows-what-else
> in arch/m68knommu/config.in ?

Yep, there sure is some crap in there :-)
Obviously left over from the original copy out
from arch/i386/config.in.

I have cleaned all that silly stuff out for the
next patch.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com


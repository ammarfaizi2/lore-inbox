Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbSJRS2m>; Fri, 18 Oct 2002 14:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265343AbSJRS2m>; Fri, 18 Oct 2002 14:28:42 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38131 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265305AbSJRS2k>;
	Fri, 18 Oct 2002 14:28:40 -0400
Message-ID: <3DB053C4.8458B0D8@mvista.com>
Date: Fri, 18 Oct 2002 11:32:36 -0700
From: Frank Rowand <frowand@mvista.com>
Reply-To: frowand@mvista.com
Organization: Montavista Software, Inc
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: karim@opersys.com
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [ltt-dev] [ANNOUNCE] LTT 0.9.6pre2: Per-CPU buffers, TSC timestamps, 
 etc.
References: <3DAF850D.D104A6D@opersys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> 
> A new development version of LTT is now available, 0.9.6pre2.
> Here's what's new:
> - Per-CPU buffering
> - TSC timestamping
> - Use of syscall interface instead of char dev abstraction
> 
> The release includes a patch for 2.5.43 which is pretty much ready
> for inclusion. I will be posting this patch raw ot the LKML with
> a more verbose description.
> 
> You will find 0.9.6pre2 here:
> http://www.opersys.com/ftp/pub/LTT/

I noticed that the Linux 2.4.19 patch is not carried forward from
pre1 to pre2.  Are you planning to no longer maintain support for
LTT in the Linux 2.4 line?

-Frank
-- 
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

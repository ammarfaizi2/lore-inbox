Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131103AbQKJPZT>; Fri, 10 Nov 2000 10:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131194AbQKJPY7>; Fri, 10 Nov 2000 10:24:59 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:61452 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S131103AbQKJPYu>; Fri, 10 Nov 2000 10:24:50 -0500
Message-ID: <3A0C131F.AE3D7FBF@holly-springs.nc.us>
Date: Fri, 10 Nov 2000 10:24:15 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <80256991.007632DE.00@d06mta06.portsmouth.uk.ibm.com> <3A09C725.6CFA0EE2@holly-springs.nc.us> <20001110170754.K13151@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> On Wed, Nov 08, 2000 at 04:35:33PM -0500, Michael Rothwell wrote:
> > Sounds great; unfortunately, the core group has spoken out against a
> > modular kernel.
> 
>         Really ?
> 
> $ /sbin/lsmod
> Module                  Size  Used by
> [...]
> soundcore               4336   4 [es1371]


Really. That the kernal has loadable modules does not mean that it is
modular.

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

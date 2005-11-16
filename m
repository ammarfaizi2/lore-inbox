Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbVKPKjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbVKPKjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 05:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbVKPKjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 05:39:17 -0500
Received: from barclay.balt.net ([195.14.162.78]:62402 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S932598AbVKPKjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 05:39:17 -0500
Date: Wed, 16 Nov 2005 12:37:52 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Zhu Yi <yi.zhu@intel.com>, Andrew Morton <akpm@osdl.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jketreno@linux.intel.com
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051116103752.GB23140@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <4378980C.7060901@ens-lyon.fr> <20051114162942.5b163558.akpm@osdl.org> <20051115100519.GA5567@gemtek.lt> <20051115115657.GA30489@gemtek.lt> <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com> <20051115140023.GB9910@gemtek.lt> <1132120145.18679.12.camel@debian.sh.intel.com> <20051116094551.GA23140@gemtek.lt> <84144f020511160205y27c494a2mee464987d3ef773e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020511160205y27c494a2mee464987d3ef773e@mail.gmail.com>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pekka,

On Wed, Nov 16, 2005 at 12:05:43PM +0200, Pekka Enberg wrote:
> Hi,
> 
> On 11/16/05, Zilvinas Valinskas <zilvinas@gemtek.lt> wrote:
> > Please see : http://www.gemtek.lt/~zilvinas/dumps/trace
> >
> > This time I didn't see oops printed again :( Don't understand why,
> > although I have managed to capture SysRQ-T output - see URL above.
> > Kernel has been updated this morning to revision:
> 
> No firmware loading errors either? Please try out the patch I sent you
> earlier _if_ the firmware still fails to load.

I will try patch posted by you in a couple our and will get back with
results. As for f/w uploading problems today I don't see them ... :) Fun
and it gets only more interesting :)

> 
> Could you please post your lspci -v output?

http://www.gemtek.lt/~zilvinas/dumps/lspci.output

> 
>                           Pekka
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUBWOlx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 09:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbUBWOlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 09:41:53 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:50050 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261904AbUBWOlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 09:41:51 -0500
Date: Mon, 23 Feb 2004 15:41:49 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Dan Kegel <dank@kegel.com>, Sean McGoogan <sean.mcgoogan@superh.com>
Subject: Re: Kernel Cross Compiling [update]
Message-ID: <20040223144149.GC4092@MAIL.13thfloor.at>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	linux-kernel@vger.kernel.org, Dan Kegel <dank@kegel.com>,
	Sean McGoogan <sean.mcgoogan@superh.com>
References: <20040222035350.GB31813@MAIL.13thfloor.at> <20040222155209.GA11162@linux-sh.org> <20040222170720.GA24703@MAIL.13thfloor.at> <20040222172307.GB11162@linux-sh.org> <20040223132819.GB16667@malvern.uk.w2k.superh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223132819.GB16667@malvern.uk.w2k.superh.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 01:28:19PM +0000, Richard Curnow wrote:
> * Paul Mundt <lethal@linux-sh.org> [2004-02-23]:
> > > is there a toolchain/binutils which 'know' and 'support'
> > > the '-isa=sh64' option? maybe it was depreciated?
> > > 
> > I don't know of one out in the wild. SuperH has their own toolchains that
> > support this, and is what I currently use. I'm not sure what the status of
> > their patches are in relation to getting merged into current gcc/binutils.
> > Richard (CC'ed) might know though, Richard?
> 
> The last public release we made of the SH-5 tools is available at
> 
>     ftp://ftp.uk.superh.com/pub/SuperH-GNU/Barcelona-20030414

how are they related to the 'mainline' toolchain?

i.e. is this something completely separate, or do
you follow the binutils/gcc updates from time to time?

what would be the binutils/gcc version which is
'closest' to 'your' toolchain? wouldn't it make
sense to get those changes back into the mainline?

> This URL provides further information:
> 
>     http://sourceforge.net/mailarchive/forum.php?thread_id=1984379&forum_id=9482
> 
> The SH-5 tools we're currently using in-house are a few months more
> advanced than those.  (They date from about August 2003.)  We'd be happy
> to package this version up and make it available if people express
> interest in this.

sure I'm interested *expressing interest*

thanks for the info,

TIA,
Herbert

> BTW, if anyone who's using the 2003_04_14 release has found any
> problems, please do let me know and I'll pass the information on to the
> toolchain guys.
> 
> -- 
> Richard \\\ SH-4/SH-5 Core & Debug Architect
> Curnow  \\\         SuperH (UK) Ltd, Bristol
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

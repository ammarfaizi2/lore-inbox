Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269589AbUJGBIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269589AbUJGBIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 21:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269591AbUJGBIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 21:08:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4331 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269589AbUJGBIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 21:08:51 -0400
Message-ID: <41649715.4040100@pobox.com>
Date: Wed, 06 Oct 2004 21:08:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>, mingo@redhat.com, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       judith@osdl.org
Subject: Re: new dev model (was Re: Default cache_hot_time value back to 10ms)
References: <200410060042.i960gn631637@unix-os.sc.intel.com> <20041005205511.7746625f.akpm@osdl.org> <416374D5.50200@yahoo.com.au> <20041005215116.3b0bd028.akpm@osdl.org> <41637BD5.7090001@yahoo.com.au> <20041005220954.0602fba8.akpm@osdl.org> <416380D7.9020306@yahoo.com.au> <20041005223307.375597ee.akpm@osdl.org> <41638E61.9000004@pobox.com> <20041005233958.522972a9.akpm@osdl.org> <41644A3D.4050100@pobox.com> <41644BF1.7030904@pobox.com> <41644E6B.5070607@pobox.com> <Pine.GSO.4.61.0410062231290.738@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.61.0410062231290.738@waterleaf.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> P.S. I only track `real' (-pre and -rc) releases. I don't have the manpower
>      (what's in a word) to track daily snapshots (I do `read' bk-commits). If
>      m68k stuff gets broken in -rc, usually it means it won't get fixed before
>      2 full releases later.  Anyway, things shouldn't become broken in -rc,
>      IMHO that's what we (should) have -pre for...


I agree completely, but -pre is apparently a dirty word (dirty suffix?:))

	Jeff



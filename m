Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269242AbTCBRCs>; Sun, 2 Mar 2003 12:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269243AbTCBRCs>; Sun, 2 Mar 2003 12:02:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9227 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S269242AbTCBRCr>;
	Sun, 2 Mar 2003 12:02:47 -0500
Message-ID: <3E623B9A.8050405@pobox.com>
Date: Sun, 02 Mar 2003 12:12:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
References: <200303020011.QAA13450@adam.yggdrasil.com> <3E615C38.7030609@pobox.com> <20030302014039.GC1364@dualathlon.random> <3E616224.6040003@pobox.com> <b3rtr2$rmg$1@cesium.transmeta.com>
In-Reply-To: <b3rtr2$rmg$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Followup to:  <3E616224.6040003@pobox.com>
> By author:    Jeff Garzik <jgarzik@pobox.com>
> In newsgroup: linux.dev.kernel
> 
>>You're missing the point:
>>
>>A BK exporter is useful.  A BK clone is not.
>>
> 
> 
> I disagree.  A BK clone would almost certainly be highly useful.  The
> fact that it would happen to be compatible with one particular
> proprietary tool released by one particular company doesn't change
> that fact one iota; in fact, some people might find value in using the
> proprietary tool for whatever reason (snazzy GUI, keeping the suits
> happy, who knows...)


While people would certainly use it, I can't help but think that a BK 
clone would damage other open source SCM efforts.  I call this the 
"SourceForge Syndrome":

	Q. I found a problem/bug/annoyance, how do I solve it?
	A. Clearly, a brand new sourceforge project is called for.

My counter-question is, why not improve an _existing_ open source SCM to 
read and write BitKeeper files?  Why do we need yet another brand new 
project?

AFAICS, a BK clone would just further divide resources and mindshare.  I 
personally _want_ an open source SCM that is as good as, or better, than 
BitKeeper.  The open source world needs that, and BitKeeper needs the 
competition.  A BK clone may work with BitKeeper files, but I don't see 
it ever being as good as BK, because it will always be playing catch-up.

	Jeff




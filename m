Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269274AbTCBS3A>; Sun, 2 Mar 2003 13:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269275AbTCBS3A>; Sun, 2 Mar 2003 13:29:00 -0500
Received: from terminus.zytor.com ([63.209.29.3]:14984 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S269274AbTCBS26>; Sun, 2 Mar 2003 13:28:58 -0500
Message-ID: <3E624FD4.3020807@zytor.com>
Date: Sun, 02 Mar 2003 10:39:16 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
References: <200303020011.QAA13450@adam.yggdrasil.com> <3E615C38.7030609@pobox.com> <20030302014039.GC1364@dualathlon.random> <3E616224.6040003@pobox.com> <b3rtr2$rmg$1@cesium.transmeta.com> <3E623B9A.8050405@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> My counter-question is, why not improve an _existing_ open source SCM to 
> read and write BitKeeper files?  Why do we need yet another brand new 
> project?
> 

I don't disagree with that.  However, the question you posited was 
"would one be useful", and I think the answer is unequivocally yes. 
Furthermore, I don't agree with the "compatibility == bad" assumption I 
read into your message.

> AFAICS, a BK clone would just further divide resources and mindshare.  I 
> personally _want_ an open source SCM that is as good as, or better, than 
> BitKeeper.  The open source world needs that, and BitKeeper needs the 
> competition.  A BK clone may work with BitKeeper files, but I don't see 
> it ever being as good as BK, because it will always be playing catch-up.

Yes.  Personally, I've spent quite a bit of time with OpenCM after a 
suggestion from Ted T'so.  It's looking quite promising to me, although 
I haven't yet used it to maintain a large project.

	-hpa



Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317451AbSFCSk5>; Mon, 3 Jun 2002 14:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317452AbSFCSk4>; Mon, 3 Jun 2002 14:40:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40720 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317451AbSFCSkz>; Mon, 3 Jun 2002 14:40:55 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: isofs unhide option:  troubles with Wine
Date: 3 Jun 2002 11:40:31 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <adgd6v$1mq$1@cesium.transmeta.com>
In-Reply-To: <1023123957.8071.140.camel@jwhite> <Pine.LNX.4.44.0206031204540.3833-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0206031204540.3833-100000@hawkeye.luckynet.adm>
By author:    Thunder from the hill <thunder@ngforever.de>
In newsgroup: linux.dev.kernel
>
> Hi,
> 
> On 3 Jun 2002, Jeremy White wrote:
> > possible rather than impossible. Question is - why was hide the default
> > and what was that decision based upon ?
> 
> Supposedly, someone wanted it _really_ hidden. I can't currently think of 
> another sane reason, I don't know if you can and it's just these 
> headaches. However, what's the advantage in disappearing files?
> 
> I suggest making them readable, but not listed.
> 

No, I think that's a bad idea.  Make them listed, but make it possible
to query the attribute flags.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

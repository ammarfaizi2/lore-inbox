Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266989AbUAXSb2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 13:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266990AbUAXSb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 13:31:27 -0500
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:25935 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S266989AbUAXSb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 13:31:26 -0500
Message-ID: <4012BA32.6040104@planet.nl>
Date: Sat, 24 Jan 2004 19:32:18 +0100
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95.3
References: <20040123145048.B1082@beton.cybernet.src> <20040123100035.73bee41f.jeremy@kerneltrap.org> <20040123151340.B1130@beton.cybernet.src> <001b01c3e1ca$26101f20$1e00000a@black> <20040123163008.B1237@beton.cybernet.src> <1074882836.20723.4.camel@minerva> <4011AC22.8050903@planet.nl> <Pine.LNX.4.58.0401241343200.11829@anguna.ploreargvpf.pbz>
In-Reply-To: <Pine.LNX.4.58.0401241343200.11829@anguna.ploreargvpf.pbz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Buescher wrote:

>snip
>
>Well, according to this list, gcc-3.3.2 at least has problems to compile
>ALSA correctly, unless you activate framepointer support.
>
>IB
>  
>
I don't seem to have any issues using ALSA since kernel 2.6.1 and gcc 
3.3.2. I'm using an soundblaster live emu10k. I did have issues before 
this kernel version and had to use OSS emulation. btw I'm using x86 
(Athlon K7)

Cheers,

Stef

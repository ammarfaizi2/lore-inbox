Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270478AbTGZR3K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 13:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270484AbTGZR3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 13:29:10 -0400
Received: from dup-200-42-137-10.prima.net.ar ([200.42.137.10]:44672 "EHLO hal")
	by vger.kernel.org with ESMTP id S270478AbTGZR3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 13:29:06 -0400
Subject: Re: Sound recording problems
From: Pablo Baena <pbaena@uol.com.ar>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1059176605.1204.16.camel@dhcp22.swansea.linux.org.uk>
References: <1059158899.1116.29.camel@hal>
	 <1059176605.1204.16.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Message-Id: <1059230564.1610.7.camel@hal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 26 Jul 2003 14:42:45 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! It would be good to have this well noticed somewhere.
I spent days and days scratching my head, not knowing it is a well known
issue.

Pablo

On Fri, 2003-07-25 at 23:43, Alan Cox wrote:
> On Gwe, 2003-07-25 at 19:48, Pablo Baena wrote:
> > I'll focus on my actual configuration, so I can debug the problem. I
> > have a SB16 Awe ISA, and I tried the OSS drivers with 2.6.0-test1.
> > I have a VIAC686 motherboard, with a K7 650Mhz processor.
> 
> Right now you need the ALSA drivers for recording on VIA. Fixing the
> OSS one is down on the todo list somewhere but nobody has tackled it
-- 
Whip it, baby. Whip it right. Whip it, baby. Whip it all night!


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWHLRSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWHLRSb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWHLRSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:18:31 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:35521 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932563AbWHLRSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:18:30 -0400
Date: Sat, 12 Aug 2006 19:14:33 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Vernon Mauery <vernux@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Eric Piel <Eric.Piel@tremplin-utc.net>,
       Steve Barnhart <stb52988@gmail.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bootsplash integration
In-Reply-To: <200608120727.58446.vernux@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0608121913490.2346@yvahk01.tjqt.qr>
References: <15ce3ec0608110736y5ef185e8v6acd4f7556adcc49@mail.gmail.com>
 <44DCB95B.4060101@tremplin-utc.net> <1155317729.24077.110.camel@localhost.localdomain>
 <200608120727.58446.vernux@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>mplayer knows how to play to a framebuffer on the console without X.  So this 
>is possible.  I have played a movie on my framebuffer before.

mplayer even works without framebuffer, and I am not talking about aalib or 
caca, but cvidix.


Jan Engelhardt
-- 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWHQTa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWHQTa7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 15:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWHQTa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 15:30:59 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:20960 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751260AbWHQTa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 15:30:57 -0400
Date: Thu, 17 Aug 2006 21:23:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?iso-8859-1?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
cc: Vernon Mauery <vernux@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Eric Piel <Eric.Piel@tremplin-utc.net>,
       Steve Barnhart <stb52988@gmail.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bootsplash integration
In-Reply-To: <20060817160247.GB25136@lgb.hu>
Message-ID: <Pine.LNX.4.61.0608172122320.10786@yvahk01.tjqt.qr>
References: <15ce3ec0608110736y5ef185e8v6acd4f7556adcc49@mail.gmail.com>
 <44DCB95B.4060101@tremplin-utc.net> <1155317729.24077.110.camel@localhost.localdomain>
 <200608120727.58446.vernux@us.ibm.com> <Pine.LNX.4.61.0608121913490.2346@yvahk01.tjqt.qr>
 <20060817160247.GB25136@lgb.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >mplayer knows how to play to a framebuffer on the console without X.  So this 
>> >is possible.  I have played a movie on my framebuffer before.
>> 
>> mplayer even works without framebuffer, and I am not talking about aalib or 
>> caca, but cvidix.
>
>As an ex-developer of MPlayer I should say that MPlayer even supports direct
>hardware access and such if you're brave enough ;-)
>
>http://www.mplayerhq.hu/DOCS/HTML-single/en/MPlayer.html#vidix

vidix does not work, but vesa and svga do. However, one of vesa/svga also 
ceased to work recently. Very sad :(


Jan Engelhardt
-- 

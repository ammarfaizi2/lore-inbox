Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312414AbSDEJJH>; Fri, 5 Apr 2002 04:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312416AbSDEJI7>; Fri, 5 Apr 2002 04:08:59 -0500
Received: from albireo.ucw.cz ([194.213.206.36]:31748 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S312414AbSDEJIs>;
	Fri, 5 Apr 2002 04:08:48 -0500
Date: Fri, 5 Apr 2002 11:08:46 +0200
From: Martin Mares <mj@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, pic 16 4/9
Message-ID: <20020405090846.GL609@ucw.cz>
In-Reply-To: <m11ydwu5at.fsf@frodo.biederman.org> <20020405080115.GA409@ucw.cz> <m1k7rmpmyq.fsf@frodo.biederman.org> <20020405084733.GG609@ucw.cz> <m1g02aplmm.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Show me a linker script that can link together bootsect.o and bsetup.o.

I don't have enough time to experiment with it at this very moment
and I admit that the linker bugs you've mentioned make it impossible,
but the objdump solution I mentioned (and tried a couple of minutes ago)
works and although it isn't perfect, it's lovely compared to the
"-start" hack.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
hAS ANYONE SEEN MY cAPSLOCK KEY?

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312408AbSDEIrz>; Fri, 5 Apr 2002 03:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312410AbSDEIrp>; Fri, 5 Apr 2002 03:47:45 -0500
Received: from albireo.ucw.cz ([194.213.206.36]:24580 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S312408AbSDEIre>;
	Fri, 5 Apr 2002 03:47:34 -0500
Date: Fri, 5 Apr 2002 10:47:33 +0200
From: Martin Mares <mj@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, pic 16 4/9
Message-ID: <20020405084733.GG609@ucw.cz>
In-Reply-To: <m11ydwu5at.fsf@frodo.biederman.org> <20020405080115.GA409@ucw.cz> <m1k7rmpmyq.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The fact that you can't treat the generated .o as a normal object
> is simply a maintenance nightmare.

Why? You can easily convert it to a normal absolute .o file by objcopy.

Also, I think you could do the same in the linker script.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Diplomacy is an art of saying "nice doggy" until you can find a rock.

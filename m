Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291851AbSBNUud>; Thu, 14 Feb 2002 15:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291886AbSBNUuY>; Thu, 14 Feb 2002 15:50:24 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:40720 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S291882AbSBNUuM>;
	Thu, 14 Feb 2002 15:50:12 -0500
Date: Thu, 14 Feb 2002 20:13:58 +0100
From: Pavel Machek <pavel@suse.cz>
To: Eugene Chupkin <ace@credit.com>
Cc: linux-kernel@vger.kernel.org, tmeagher@credit.com
Subject: Re: 2.4.x ram issues?
Message-ID: <20020214191356.GB160@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10202121726530.683-100000@mail.credit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10202121726530.683-100000@mail.credit.com>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have a problem with high ram support on 2.4.7 to 2.4.17 all behave the
> same. I have a quad Xeon 700 box with 16gb of ram on an Intel SKA4 board.
> The ram is all the same 16 1gb PC100 SDRAM modules from Crucial. If I
> compile the kernel with high ram (64gb) support, my system runs very slow,
> it takes about 15 minutes for make menuconfig to come up. If I  recompile
> the kernel with 4gb support, it runs perfectly normal and very fast, but I
> have 12 gigs that I can't use. Is this a known issue? Is there a fix? I
> tried just about everything and I am all out of options. Please help!

What happens with 8GB?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317757AbSFLS3O>; Wed, 12 Jun 2002 14:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317758AbSFLS3N>; Wed, 12 Jun 2002 14:29:13 -0400
Received: from [195.39.17.254] ([195.39.17.254]:8355 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317757AbSFLS3N>;
	Wed, 12 Jun 2002 14:29:13 -0400
Date: Wed, 12 Jun 2002 10:43:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Message-ID: <20020612084349.GA986@elf.ucw.cz>
In-Reply-To: <200206100356.UAA17066@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> # BUGs	|	File Name
> 4	|	/drivers/cdrom.c
> 4	|	/message/i2o_proc.c
> 3	|	/net/airo.c
> 3	|	/../inflate.c
> 2	|	/fs/zlib.c
> 2	|	/drivers/zlib.c
> 2	|	/drivers/cpqfcTScontrol.c
		~~~~~~~~~~~~~~~~~~~~~~~~~

Actually, 3 bugs, the name is so ugly that it is a bug, too :-).
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbSK1K6E>; Thu, 28 Nov 2002 05:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265413AbSK1K6E>; Thu, 28 Nov 2002 05:58:04 -0500
Received: from [195.39.17.254] ([195.39.17.254]:14852 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265396AbSK1K6D>;
	Thu, 28 Nov 2002 05:58:03 -0500
Date: Tue, 26 Nov 2002 23:04:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.23-rc2 & an MCE
Message-ID: <20021126220459.GA229@elf.ucw.cz>
References: <20021125202033.A1212@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021125202033.A1212@jaquet.dk>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I just had an MCE on my aging PPro 200. Before I go out to
> buy a replacement I would like to hear if it could be
> caused by anything other than the CPU. Googling a bit
> gave some indications that sometimes other HW might report
> failure through this method.
> 
> The MCE (hand copied):
> 
> Machine Check Exception: 000000000000004
> Bank 4: b200000000040151
> Kernel panic: CPU context corrupt

Is not it trying to tell you about bad ram?



-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?

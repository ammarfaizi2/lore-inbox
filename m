Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbTBCT7a>; Mon, 3 Feb 2003 14:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbTBCT6J>; Mon, 3 Feb 2003 14:58:09 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1284 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265230AbTBCTxu>;
	Mon, 3 Feb 2003 14:53:50 -0500
Date: Mon, 3 Feb 2003 13:53:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Willy Tarreau <willy@w.ods.org>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Compactflash cards dying?
Message-ID: <20030203125344.GA480@elf.ucw.cz>
References: <20030202223009.GA344@elf.ucw.cz> <20030202235759.GA6859@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030202235759.GA6859@alpha.home.local>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I had this same problem with my very first CF (16 MB) connected to a home-made
> IDE adapter. I quickly discovered that the power wire (+5V) had been cut and
> that the power was driven through the logic signals, which were strong enough
> to let the card work correctly... nearly correctly. Because it got uncorrectable
> defects, detected as bad sectors at IDE level. So may be your adapter is too
> weak. Or may be you also use it in a battery-powered device which has frequent
> power outages ?

I've seen it on sharp zaurus, and same flash had bad problems in
toshiba 4030cdt notebook. Zaurus is PDA but it *does* monitor voltage;
I can't imagine toshiba having problems with power.

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?

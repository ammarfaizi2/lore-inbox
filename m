Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267427AbSLEUyy>; Thu, 5 Dec 2002 15:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbSLEUyx>; Thu, 5 Dec 2002 15:54:53 -0500
Received: from [195.39.17.254] ([195.39.17.254]:6404 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267435AbSLEUyw>;
	Thu, 5 Dec 2002 15:54:52 -0500
Date: Thu, 5 Dec 2002 00:45:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Martin Kacer <M.Kacer@sh.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bttv: Strange frame drop-outs during TV grabbing
Message-ID: <20021204234501.GA163@elf.ucw.cz>
References: <Pine.LNX.4.21.0212021113560.8265-100000@nightmare.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0212021113560.8265-100000@nightmare.sh.cvut.cz>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 5) The regular period is retained when I quit the MEncoder and run it
> again. I.e., it happens every 55 seconds of REAL time, even if the new
> MEncoder instance is run. This is why I think it is NOT the MEncoder
> issue!

ext3? 55 sounds like journal flush interval..

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?

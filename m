Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVABUhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVABUhW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVABUhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:37:21 -0500
Received: from news.suse.de ([195.135.220.2]:20920 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261331AbVABUgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:36:25 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Pavel Machek <pavel@ucw.cz>, luto@myrealbox.com, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
References: <20050102193724.GA18136@elf.ucw.cz>
	<20050102201147.GB4183@stusta.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Hiccuping & trembling into the WASTE DUMPS of New Jersey like some
 drunken CABBAGE PATCH DOLL, coughing in line at FIORUCCI'S!!
Date: Sun, 02 Jan 2005 21:36:24 +0100
In-Reply-To: <20050102201147.GB4183@stusta.de> (Adrian Bunk's message of
 "Sun, 2 Jan 2005 21:11:47 +0100")
Message-ID: <jemzvry3ef.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> What's wrong with
>
>   fuser -k /mnt && umount /mnt

Better: fuser -km /mnt

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

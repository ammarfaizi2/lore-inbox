Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313665AbSDHPAG>; Mon, 8 Apr 2002 11:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313666AbSDHPAF>; Mon, 8 Apr 2002 11:00:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21523 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S313665AbSDHPAE>; Mon, 8 Apr 2002 11:00:04 -0400
Date: Mon, 8 Apr 2002 17:00:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Make swsusp actually work
Message-ID: <20020408150005.GC29960@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020407233725.GA15559@elf.ucw.cz> <1018254348.571.129.camel@psuedomode> <20020408102508.GA2494@elf.ucw.cz> <1018275683.10462.134.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> the documentation suggests that you do not need to specify resume= .  Is
> this only true if you have the sysvinit patch in use?  Is swapon -a

Then docs is wrong.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.

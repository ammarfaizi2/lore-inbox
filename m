Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbTAaRDB>; Fri, 31 Jan 2003 12:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbTAaRDB>; Fri, 31 Jan 2003 12:03:01 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8196 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261600AbTAaRCI>;
	Fri, 31 Jan 2003 12:02:08 -0500
Date: Thu, 30 Jan 2003 08:25:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Raphael Schmid <Raphael_Schmid@CUBUS.COM>,
       "'John Bradford'" <john@grabjohn.com>, rob@r-morris.co.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
Message-ID: <20030130072521.GA559@zaurus>
References: <398E93A81CC5D311901600A0C9F2928946937F@cubuss2> <1043764502.24813.16.camel@bip.localdomain.fake>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043764502.24813.16.camel@bip.localdomain.fake>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Yeah, I'd really like a stable working swsusp (on a working kernel) to
> shortcut the fscking boot. Go pawel !

Well, with right scripts you can probably boot
faster than do resume (and you can certainly
shutdown faster than suspend). OTOH, if you
turn off ide-scsi in 2.5.59, swsusp should just
work.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...


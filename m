Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314417AbSD0TgH>; Sat, 27 Apr 2002 15:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314420AbSD0TgG>; Sat, 27 Apr 2002 15:36:06 -0400
Received: from [195.39.17.254] ([195.39.17.254]:11153 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314417AbSD0TgF>;
	Sat, 27 Apr 2002 15:36:05 -0400
Date: Thu, 25 Apr 2002 20:50:36 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Bill Davidsen <davidsen@tmr.com>,
        Stephen Samuel <samuel@bcgreen.com>, linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
Message-ID: <20020425205035.A160@toy.ucw.cz>
In-Reply-To: <20020426040457.GO574@matchmail.com> <Pine.LNX.4.10.10204260028140.10216-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Basically it is a global design flaw from the beginning, and since I have
> only 2.4 to address it is a real nasty!  Short version, each subdriver

Well, noone prevents you from submitting 2.5 patches to Martin.... Actually,
his cleanups maybe made that job easier.

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


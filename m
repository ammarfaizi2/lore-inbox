Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267662AbTAaByh>; Thu, 30 Jan 2003 20:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267668AbTAaByh>; Thu, 30 Jan 2003 20:54:37 -0500
Received: from ip68-101-124-193.oc.oc.cox.net ([68.101.124.193]:63361 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S267662AbTAaByg>; Thu, 30 Jan 2003 20:54:36 -0500
Date: Thu, 30 Jan 2003 18:04:00 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Lars 'Cebewee' Noschinski" <CebeWee@gmx.de>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       John Bradford <john@grabjohn.com>,
       "(jeff millar)" <wa1hco@adelphia.net>, Raphael_Schmid@CUBUS.COM,
       rob@r-morris.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Scaring the non-geeks (was Bootscreen)
Message-ID: <20030131020400.GA17427@ip68-4-86-174.oc.oc.cox.net>
References: <200301281440.h0SEeBS8001126@darkstar.example.net> <200301291409.57213.roy@karlsbakk.net> <961914102.20030130195303@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <961914102.20030130195303@gmx.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 07:53:03PM +0100, Lars 'Cebewee' Noschinski wrote:
> Till Windows Me, every Windows user got textmode messages at boot time.
> And they survived it.

Most Win98 boxes (at least in my experience) don't show text-mode
message as boot either. Same for *all* of the (now rare) Win95 boxes
I've seen lately.

It depends on whether you have any DOS programs installed in
autoexec.bat or config.sys that output text. AFAICT many old antivirus
programs used to spew stuff at boot, but as people update their
antivirus programs over time, this is becoming less common.

Also, Win95/98 rarely displayed more than a screenful of text, virtually
never displayed more than two screenfuls, and usually displayed only a
few lines. Compare with Linux, spewing a multi-screen waterfall of text
before init even starts. Some people respond by backing away from the
computer in fear. Others say things like "Daaaaaaamn!" when they
suddenly recognize the true speed of their video hardware.

I haven't tried confronting an average person with "quiet" added to the
boot command line arguments yet. That might be sufficient to fix the
problem. (OTOH I haven't read the full thread yet so I don't know if
anyone else has tried this.)

-Barry K. Nathan <barryn@pobox.com>

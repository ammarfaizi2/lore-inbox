Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbTBTDgl>; Wed, 19 Feb 2003 22:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbTBTDgl>; Wed, 19 Feb 2003 22:36:41 -0500
Received: from w240.z209220232.was-dc.dsl.cnc.net ([209.220.232.240]:31759
	"EHLO yendi.dmeyer.net") by vger.kernel.org with ESMTP
	id <S264749AbTBTDgk>; Wed, 19 Feb 2003 22:36:40 -0500
Date: Wed, 19 Feb 2003 22:46:42 -0500
From: dmeyer@dmeyer.net
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.x freezes on booting
Message-ID: <20030220034642.GA28284@jhereg.dmeyer.net>
Reply-To: dmeyer@dmeyer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302192240.22261.gilsonr@cityisp.net>
User-Agent: Mutt/1.4i
X-Newsgroups: local.linux.kernel
Organization: dmeyer.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200302192240.22261.gilsonr@cityisp.net> you write:
> Hi!
> 
> I've rechecked my procedures, have gone through the archive without result.
> 
> I compiled 2.4.19 and 2.4.20 (which I'm using right now) without
> problem, but 2.5.x is, so far, winning over me.

You and everyone else trying to use initrds.  There have been
substantial module changes, and apparently mkinitrd is badly broken.
Look in the linux-kernel archives for recent posts by Bill Davidsen
(davidsen@tmr.com) - he's done a bunch of investigating but hasn't had
much success making it work.

-- 
Dave Meyer
dmeyer@dmeyer.net

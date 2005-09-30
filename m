Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbVI3Mow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbVI3Mow (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 08:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbVI3Mov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 08:44:51 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:18086 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1751448AbVI3Mot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 08:44:49 -0400
Date: Fri, 30 Sep 2005 14:44:48 +0200
From: Sander <sander@humilis.net>
To: Danny ter Haar <dth@cistron.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.14-rc2-git7 crashed on amd64 (usenet gateway) after 18 hours
Message-ID: <20050930124448.GA12779@favonius>
Reply-To: sander@humilis.net
References: <dhinf5$skf$1@news.cistron.nl> <20050930001301.08eeab9d.akpm@osdl.org> <20050930073958.GA24985@dth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930073958.GA24985@dth.net>
X-Uptime: 10:52:35 up 54 days, 20:17, 29 users,  load average: 1.00, 1.00, 1.00
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny ter Haar wrote (ao):
> Quoting Andrew Morton (akpm@osdl.org):
> > So we've probably lost the info which will tell us how the problems
> > started.  A serial console would be nice.
> 
> This is from serial console.
> Unfortunatly it's a portmaster2 which has no buffer.
> What i do is start a screen, do a telnet to the portmaster
> and attach the serial console. I can't go back anyfurther
> than this since the output of the new kernel booting replaced it.
> Mayby i can tell screen to have more lines of history ?! 

This might help?

>From 'man screen':

       C-a H       (log)         Begins/ends logging of the current window  to
                                 the file "screenlog.n".

-- 
Humilis IT Services and Solutions
http://www.humilis.net

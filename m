Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbTGSLuf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 07:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbTGSLue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 07:50:34 -0400
Received: from tazz.wtf.dk ([80.199.6.58]:2688 "EHLO sokrates")
	by vger.kernel.org with ESMTP id S265531AbTGSLue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 07:50:34 -0400
Date: Sat, 19 Jul 2003 14:05:30 +0200
From: Michael Kristensen <michael@wtf.dk>
To: Ian Hastie <ianh@iahastie.clara.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: More 2.6.0-test1-ac2 issues / nvidia kernel module
Message-ID: <20030719120530.GA549@sokrates>
References: <20030718154918.GA27176@charite.de> <200307190413.56193.ianh@iahastie.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200307190413.56193.ianh@iahastie.local.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ian Hastie <ianh@iahastie.clara.net> [2003-07-19 12:22:06]:
> And that's the problem.  The new modprobe uses /etc/modprobe.conf rather than 
> /etc/modules.conf.  In Debian you now need to put the component files into 
> /etc/modprobe.d instead of /etc/modutils.  However the syntax appears to be 
> mostly the same so the configuration files you already have should still 
> work.

Oh! Thanks for this info. I have had problems figuring out why my
aliases in /etc/modutils/aliases and other stuff didn't work... Now even
ALSA runs perfectly on my system. Thank you very much.

-- 
Med Venlig Hilsen/Best Regards/Mit freundlichen Grüßen
Michael Kristensen <michael@wtf.dk>

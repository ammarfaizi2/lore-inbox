Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270189AbTGZQhp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 12:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270412AbTGZQhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 12:37:45 -0400
Received: from smtp.terra.es ([213.4.129.129]:56632 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id S270189AbTGZQho convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 12:37:44 -0400
Date: Sat, 26 Jul 2003 18:52:56 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Daniel Phillips <phillips@arcor.de>
Cc: ed.sweetman@wmich.edu, eugene.teo@eugeneteo.net,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Message-Id: <20030726185256.04a8c88f.diegocg@teleline.es>
In-Reply-To: <200307271046.30318.phillips@arcor.de>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com>
	<20030726101015.GA3922@eugeneteo.net>
	<3F2264DF.7060306@wmich.edu>
	<200307271046.30318.phillips@arcor.de>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 27 Jul 2003 10:46:30 -0500 Daniel Phillips <phillips@arcor.de> escribió:

> Audio players fall into a special category of application, the kind where it's 
> not unreasonable to change the code around to take advantage of new kernel 
> features to make them work better.  Remember this word: audiophile.  An 
> audiophile will do whatever it takes to attain more perfect reproduction.  
> Furthermore, where goes the audophile, soon follows the regular user.  Just 
> go into a stereo store if you need convincing about that.

I wonder if X falls in this category too; the X behaviour should be as
good as the scheduler allows it; but for a "desktop user" X behaviour
should be reponsive *always* (ie: it should have priority even if it
doesn't need it) and i wonder if that should be changed too.

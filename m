Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270644AbTGZWtX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 18:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270629AbTGZWqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 18:46:54 -0400
Received: from smtp.terra.es ([213.4.129.129]:50025 "EHLO tsmtp6.mail.isp")
	by vger.kernel.org with ESMTP id S270622AbTGZWqi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 18:46:38 -0400
Date: Sun, 27 Jul 2003 01:01:53 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Andrew Morton <akpm@osdl.org>
Cc: phillips@arcor.de, ed.sweetman@wmich.edu, eugene.teo@eugeneteo.net,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Message-Id: <20030727010153.7e2e0d48.diegocg@teleline.es>
In-Reply-To: <20030726113522.447578d8.akpm@osdl.org>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com>
	<20030726101015.GA3922@eugeneteo.net>
	<3F2264DF.7060306@wmich.edu>
	<200307271046.30318.phillips@arcor.de>
	<20030726113522.447578d8.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 26 Jul 2003 11:35:22 -0700 Andrew Morton <akpm@osdl.org> escribió:

> It is interesting that Felipe says that stock 2.5.69 was the best CPU
> scheduler of the 2.5 series.  Do others agree with that?

No.
For me, 2.5.63 was the best. Or perhaps it was .64 or .65?

What I know is that the best CPU scheduler was the one previous 
to the "interactivity changes" from Linus. I mean, if Linus' changes
went in .65, then it's .64, etc.

Perhaps for other people it's .69....probably it also depends a lot
on the hardware side. For me .63 was "good"

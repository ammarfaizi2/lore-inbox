Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbUART6w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 14:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUART6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 14:58:52 -0500
Received: from smtp-out2.iol.cz ([194.228.2.87]:13481 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263466AbUART6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 14:58:50 -0500
Date: Sun, 18 Jan 2004 20:58:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rik van Riel <riel@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Valdis.Kletnieks@vt.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sched-idle and disk-priorities for 2.6.X
Message-ID: <20040118195825.GA27658@elf.ucw.cz>
References: <20040117232926.GC9999@elf.ucw.cz> <Pine.LNX.4.44.0401181346480.28955-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401181346480.28955-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Is there effective way to limit RSS?
> 
> Want me to port the RSS stuff from 2.4-rmap to 2.6 ?

Well, if it allows me to limit memory for one task so that it does not
make system unusable... yes, that would be great.
								Pavel
-- 
When do you have heart between your knees?

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbTDFVSR (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbTDFVSR (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:18:17 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:4526 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263087AbTDFVSQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 17:18:16 -0400
Date: Sun, 6 Apr 2003 23:29:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: swsusp - 2.5.66 incremental
Message-ID: <20030406212931.GB693@elf.ucw.cz>
References: <1049537149.1709.6.camel@laptop-linux.cunninghams> <20030406182016.GA17666@atrey.karlin.mff.cuni.cz> <1049663561.3199.29.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049663561.3199.29.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You really should have moved it to the driver model... having #ifdef
> > in suspend.c for every driver would be very ugly.
> 
> Sorry. I thought that was the maintainer's job.

Well, his job is to tell you to do it properly. Don't expect him to do
the rewriting himself. [Also he probably is not using swsusp so he
would not test that.]
								Pavel
-- 
When do you have heart between your knees?

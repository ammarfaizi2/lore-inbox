Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbTEGXHB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbTEGXGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:06:42 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:49852 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264346AbTEGXFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:05:43 -0400
Date: Thu, 8 May 2003 01:16:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Levon <levon@movementarian.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, lm@bitmover.org
Subject: Re: bkcvs not up-to-date?
Message-ID: <20030507231603.GA699@elf.ucw.cz>
References: <20030507111552.GA325@elf.ucw.cz> <20030507115759.GA38506@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507115759.GA38506@compsoc.man.ac.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > and checked out the tree, but cvs log Makefile still indicates 2.5.68
> > is the lastest version. What am I doing wrong?
> 
> I have the same problem, the CVS gateway got stuck some point in the
> middle of 2.5.68 and has had no apparen t updates since

Its even worse: part of updates gets there. Like CREDITS file is
up-to-date but Makefile is not.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

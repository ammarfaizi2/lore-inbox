Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbUBXVjM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbUBXVjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:39:12 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:32467 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262478AbUBXVjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:39:09 -0500
Date: Tue, 24 Feb 2004 14:39:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Split kgdb into "lite" and "normal" parts
Message-ID: <20040224213908.GD1052@smtp.west.cox.net>
References: <20040218225010.GH321@elf.ucw.cz> <200402191322.52499.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402191322.52499.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 01:22:52PM +0530, Amit S. Kale wrote:

> Hi,
> 
> Tested (core-lite.patch + i386-lite.patch + 8250.patch) combination.
> Looks good.
> 
> Let's first check this in and then do more cleanups.
> Tom, does it sound ok?

This sounds fine to me.  Pavel, I'm guessing you did this with quilt,
could you provide some pointers on how to replicate this in the future?

-- 
Tom Rini
http://gate.crashing.org/~trini/

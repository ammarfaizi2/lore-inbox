Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVJ3MRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVJ3MRg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 07:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVJ3MRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 07:17:36 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26558 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932143AbVJ3MRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 07:17:35 -0500
Date: Sun, 30 Oct 2005 13:17:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org, ast@domdv.de
Subject: Re: [RFC][PATCH 0/6] swsusp: rework swap handling
Message-ID: <20051030121719.GA19134@elf.ucw.cz>
References: <200510292158.11089.rjw@sisk.pl> <20051029230515.GE14209@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051029230515.GE14209@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have divided the changes into some more or less logical steps for clarity.
> > Although the code has been designed as proof-of-concept, it is functional
> > and has been tested on x86-64, except for the cryptographic functionality
> > and error paths.
> 
> Don't worry about crypto paths too much. It is my fault, I should not
> have taken them in the first place. Just ask ast for testing when you
> are reasonably confident it will work.

We exchanged few emails with ast, and he'll probably not kill me if I
remove crypto swsusp support. That's good news ;-).
								Pavel
-- 
Thanks, Sharp!

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932735AbVJ2XF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbVJ2XF3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 19:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbVJ2XF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 19:05:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9362 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932735AbVJ2XF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 19:05:28 -0400
Date: Sun, 30 Oct 2005 01:05:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
Subject: Re: [RFC][PATCH 0/6] swsusp: rework swap handling
Message-ID: <20051029230515.GE14209@elf.ucw.cz>
References: <200510292158.11089.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510292158.11089.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have divided the changes into some more or less logical steps for clarity.
> Although the code has been designed as proof-of-concept, it is functional
> and has been tested on x86-64, except for the cryptographic functionality
> and error paths.

Don't worry about crypto paths too much. It is my fault, I should not
have taken them in the first place. Just ask ast for testing when you
are reasonably confident it will work.
								Pavel
-- 
Thanks, Sharp!

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVKUSRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVKUSRI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 13:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVKUSRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 13:17:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16570 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932433AbVKUSRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 13:17:07 -0500
Date: Mon, 21 Nov 2005 18:59:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sascha Sommer <saschasommer@freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sleeping function called from invaled context at mm/slab.c:2472
Message-ID: <20051121175905.GC2642@elf.ucw.cz>
References: <200511211744.25859.saschasommer@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511211744.25859.saschasommer@freenet.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm not sure if this is the right place to report but
> suspend to disk in 2.6.15-rc2 triggers the following:

This is ACPI problem... known one, and hard to solve, IIRC.

						Pavel
-- 
Thanks, Sharp!

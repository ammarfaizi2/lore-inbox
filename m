Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932744AbVJ2XVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744AbVJ2XVs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 19:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbVJ2XVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 19:21:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14781 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932736AbVJ2XVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 19:21:47 -0400
Date: Sun, 30 Oct 2005 01:21:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
Subject: Re: [RFC][PATCH 4/6] swsusp: move swap check out of swsusp_suspend
Message-ID: <20051029232134.GG14209@elf.ucw.cz>
References: <200510292158.11089.rjw@sisk.pl> <200510292236.47960.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510292236.47960.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is a non-essential step making the next patch possible.  No functionality
> changes.

If you can push this before 3/6, that would be nice.

								Pavel
-- 
Thanks, Sharp!

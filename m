Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVIYVr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVIYVr4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 17:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVIYVr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 17:47:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37549 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932304AbVIYVr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 17:47:56 -0400
Date: Sun, 25 Sep 2005 23:47:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/3] swsusp: fix some obscure bugs
Message-ID: <20050925214708.GA2775@elf.ucw.cz>
References: <200509252018.36867.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509252018.36867.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following series of patches fixes some obscure bugs in swsusp.

Andrew, could you apply parts #1 and #2? First is data-corruption in
error path (nasty!), second is simple bugfix.

Alternatively, I'll eat them into my tree and mail you proper patches
with all signed-offs, but that will be tommorow. (Have to get some
sleep now.)
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

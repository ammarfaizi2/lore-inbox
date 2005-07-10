Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVGJSVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVGJSVA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 14:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVGJSVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 14:21:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58273 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262007AbVGJSU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 14:20:57 -0400
Date: Sun, 10 Jul 2005 20:21:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [42/48] Suspend2 2.1.9.8 for 2.6.12: 618-core.patch
Message-ID: <20050710182106.GI10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164443244@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164443244@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Have you seen Christoph's recent fixes to refrigerator? You probably
have same problems..... And he wanted to move refrigerator to sched/
and make it more generic for page migration, too... what about using
it, too? ;-).
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.

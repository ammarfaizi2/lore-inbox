Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933028AbWFWLAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933028AbWFWLAT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 07:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933027AbWFWLAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 07:00:18 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38090 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S933017AbWFWLAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 07:00:15 -0400
Date: Fri, 23 Jun 2006 12:59:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove kernel/power/pm.c:pm_unregister_all()
Message-ID: <20060623105909.GH5343@elf.ucw.cz>
References: <20060623105543.GO9111@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623105543.GO9111@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch removes the deprecated and no longer used pm_unregister_all().
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Its always nice to see obsolete stuff being removed. Thanks and ACK!
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

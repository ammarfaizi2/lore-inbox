Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbWHXNUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWHXNUs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWHXNUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:20:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22173 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751516AbWHXNUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:20:48 -0400
Date: Thu, 24 Aug 2006 15:20:39 +0200
From: Pavel Machek <pavel@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.28-rc2
Message-ID: <20060824132039.GC7055@elf.ucw.cz>
References: <20060822230102.GC19896@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822230102.GC19896@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Pavel Machek:
>       remove obsolete swsusp_encrypt

Probably not a big deal, but IIRC this was cleanup patch. I am not
sure if it is worth merging into -stable.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUGCVKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUGCVKe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 17:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbUGCVKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 17:10:34 -0400
Received: from gprs214-161.eurotel.cz ([160.218.214.161]:15490 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265264AbUGCVJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 17:09:36 -0400
Date: Sat, 3 Jul 2004 23:08:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dario <ddario@tiscali.it>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CPU fan
Message-ID: <20040703210840.GA1459@elf.ucw.cz>
References: <007a01c45edd$2f2b3280$5c00a8c0@itia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007a01c45edd$2f2b3280$5c00a8c0@itia.local>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Sorry for the previou wrong subject :-(

echo 0 > /proc/acpi/.../fan/..., if you are lucky and your laptop
supports it.

							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

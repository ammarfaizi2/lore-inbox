Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286394AbRLTVe5>; Thu, 20 Dec 2001 16:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286396AbRLTVer>; Thu, 20 Dec 2001 16:34:47 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:25869 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S286394AbRLTVeg>;
	Thu, 20 Dec 2001 16:34:36 -0500
Date: Thu, 20 Dec 2001 21:50:16 +0100
From: Pavel Machek <pavel@suse.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
        Swsusp mailing list <swsusp@lister.fornax.hu>
Subject: swsusp for 2.5.1
Message-ID: <20011220215016.A3380@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here's swsusp, ported to 2.5.1. This allows you to suspend-to-disk on
any machine. Please apply,
							Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281244AbRKPIi1>; Fri, 16 Nov 2001 03:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281245AbRKPIiH>; Fri, 16 Nov 2001 03:38:07 -0500
Received: from [194.213.32.133] ([194.213.32.133]:25475 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S281244AbRKPIiC>;
	Fri, 16 Nov 2001 03:38:02 -0500
Date: Thu, 15 Nov 2001 23:35:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: __get_free_pages but no get_free_pages?
Message-ID: <20011115233528.A7496@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

free_pages() exists.
__get_free_pages() exists.
get_free_pages() does not. Why? What's the reason get_free_pages
always has two underscores at the beggining?
							Pavel
-- 
STOP THE WAR! Someone killed innocent Americans. That does not give
U.S. right to kill people in Afganistan.



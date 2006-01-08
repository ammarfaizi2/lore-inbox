Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932743AbWAHSYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743AbWAHSYh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWAHSYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:24:37 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20891 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932738AbWAHSYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:24:36 -0500
Date: Sun, 8 Jan 2006 15:16:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan Spitalnik <lkml@spitalnik.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable swsusp on CONFIG_HIGHMEM64
Message-ID: <20060108141640.GA1690@elf.ucw.cz>
References: <200601061945.09466.lkml@spitalnik.net> <200601071604.03846.lkml@spitalnik.net> <20060106043019.GA2545@ucw.cz> <200601072042.07337.lkml@spitalnik.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601072042.07337.lkml@spitalnik.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried pretty recent -git, and selecting HIGHMEM64 breaks boot,
too. I guess I'm giving up for now.
							Pavel

-- 
Thanks, Sharp!

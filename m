Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbTFORxX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTFORxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:53:23 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:65409 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262490AbTFORxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:53:22 -0400
Date: Sun, 15 Jun 2003 20:06:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: CaT <cat@zip.com.au>
Cc: swsusp@lister.fornax.hu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.70-bk16 - nfs interferes with s4bios suspend
Message-ID: <20030615180659.GB315@elf.ucw.cz>
References: <20030613033703.GA526@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613033703.GA526@zip.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  stopping tasks failed (2 tasks remaining)
> Suspend failed: Not all processes stopped!
> Restarting tasks...<6> Strange, rpciod not stopped
>  Strange, lockd not stopped
> XFree86 left refrigerator
> init left refrigerator
> khubd left refrigerator
> 
> then it kept unfreezing my tasks till the following debug stuff 
> came up:

Do you volunteer to test the patches?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

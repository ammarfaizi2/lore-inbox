Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTJGUQA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 16:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTJGUQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 16:16:00 -0400
Received: from gprs149-208.eurotel.cz ([160.218.149.208]:4228 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262762AbTJGUP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 16:15:59 -0400
Date: Tue, 7 Oct 2003 22:15:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l: bttv driver update
Message-ID: <20031007201534.GA2148@elf.ucw.cz>
References: <20031007105846.GA3426@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031007105846.GA3426@bytesex.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch updates the bttv driver.  It depends on the videobuf patch.
> Changes:
> 
>   * usual tv card list updates.
>   * sysfs adaptions.
>   * new, experimental i2c adapter code for bt878 chips
>     (not used by default yet).
>   * various minor fixes.
> 
> Please apply,

Are those "IR remote using input layer" patches going in?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

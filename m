Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751823AbWJMTsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbWJMTsX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWJMTsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:48:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37644 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751823AbWJMTsW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:48:22 -0400
Date: Fri, 13 Oct 2006 19:48:08 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 update 2] drivers: add LCD support
Message-ID: <20061013194807.GA4026@ucw.cz>
References: <20061012140422.93e7330c.maxextreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012140422.93e7330c.maxextreme@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Andrew, here it is the patch for converting the cfag12864b driver
> to a framebuffer driver as Pavel requested and as I promised :)
> 
> Pavel, yep, now I can login in my tiny 128x64 LCD.
> It is pretty amazing to run vi on it... ;)

Thanks, it is a lot better now.

Can you rename driver to something that does not look like password?


							Pavel
-- 
Thanks for all the (sleeping) penguins.

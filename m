Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTI1QAf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 12:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTI1QAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 12:00:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17384 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262591AbTI1QAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 12:00:34 -0400
Date: Sun, 28 Sep 2003 18:00:22 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] select for drivers/mtd
Message-ID: <20030928160022.GI15338@fs.tum.de>
References: <20030928153817.GH15338@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030928153817.GH15338@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 05:38:17PM +0200, Adrian Bunk wrote:

> The patch below switches fs/Kconfig to use select where appropriate.
>...

s|fs/Kconfig|drivers/mtd|

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


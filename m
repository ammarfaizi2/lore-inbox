Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317204AbSFFWId>; Thu, 6 Jun 2002 18:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317205AbSFFWIc>; Thu, 6 Jun 2002 18:08:32 -0400
Received: from [195.39.17.254] ([195.39.17.254]:59552 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317204AbSFFWI3>;
	Thu, 6 Jun 2002 18:08:29 -0400
Date: Thu, 6 Jun 2002 23:12:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
Subject: tx3912 Re: [PATCH] fbdev updates.
Message-ID: <20020606211252.GA1112@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.44.0206041248330.1200-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    This patch includes the latest in the fbdev BK repository. I have
> modified several fbdev drivers (maxinefb, tx3912fb, pmag drivers) to the
> new api. Please test these changes out before I submit them to linus.
> Thank you. It is against the latest BK tree and 2.5.20.

Does the code even boot on any machine having tx3912fb?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

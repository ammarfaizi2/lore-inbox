Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265954AbSKBMoo>; Sat, 2 Nov 2002 07:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265956AbSKBMoo>; Sat, 2 Nov 2002 07:44:44 -0500
Received: from [195.39.17.254] ([195.39.17.254]:4356 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265954AbSKBMoh>;
	Sat, 2 Nov 2002 07:44:37 -0500
Date: Fri, 1 Nov 2002 22:11:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BK console] console updates.
Message-ID: <20021101211153.GA171@elf.ucw.cz>
References: <Pine.LNX.4.33.0210301343580.1392-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210301343580.1392-100000@maxwell.earthlink.net>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    Along with the new fbdev api I also have rewritten the console layer.
> The goals are:

Current 2.5.45 (and previous 2.5's) has funny problems on my vesafb
machines [like half of letters appearing during emacs session, to the
point you do ^L to repaint]. I hope this fixes it....
								Pavel
-- 
When do you have heart between your knees?

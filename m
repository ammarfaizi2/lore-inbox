Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264530AbTCYUjk>; Tue, 25 Mar 2003 15:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264531AbTCYUjk>; Tue, 25 Mar 2003 15:39:40 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:10255 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264530AbTCYUji>; Tue, 25 Mar 2003 15:39:38 -0500
Date: Tue, 25 Mar 2003 20:50:47 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Florin Iucha <florin@iucha.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Framebuffer updates.
In-Reply-To: <20030325182746.GA8769@iucha.net>
Message-ID: <Pine.LNX.4.44.0303252049550.6228-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Where can I find working "modelines" for Radeon 8500?
> 
> I have a 
>    radeonfb: ATI Radeon 8500 QL DDR SGRAM 64 MB
> 
> I am interested in 1024x768 and 1152x864. I have tried the defaults
> that come with Debian fbset (2.1-8) but I get garbled screen upon
> changing the video mode. I can 'clear' the console and work more or
> less normally but the viewport will be just a part of the whole
> screen.

Try using stty. I see most people will continue to use fbset so I guess I 
need to patch it up to do the right thing.



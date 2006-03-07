Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWCGVnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWCGVnz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWCGVny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:43:54 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31184 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932100AbWCGVny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:43:54 -0500
Date: Tue, 7 Mar 2006 22:43:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Mittendorfer <delist@gmx.net>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [SUSPEND] Screen slides down after STR / neomagic
Message-ID: <20060307214337.GA1777@elf.ucw.cz>
References: <20060306100905.0199e7b5.delist@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306100905.0199e7b5.delist@gmx.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 06-03-06 10:09:05, Richard Mittendorfer wrote:
> Hello,
> 
> Toshiba Libretto; Every time I suspend to RAM an come back to Console or
> later exit Xorg (it's ok within X), the screen is somewhat displaced
> downward:
> 
>    physical screen:                video output:
>   -----------------------  -  -  -  -  -  -  -  -  -  -  
>   |                     |         -----------------------
>   |                     |         |$                    |
>   |                     |         |                     |
>   |                     |         |                     |
>   -----------------------  -   -  | -   -   -   -   -  -|
>                                   ----------------------- snipped
> 
> First noticed this with IIRC kernel 2.6.12, quite a while ago, and now
> want to do something about it. I don't use (it doesn't occur with)
> the (neomagic) framebuffer videodriver. Bootoption is vga=5, but
> choosing another doesn't fix it.

Did you read Doc*/power/video.txt?
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...

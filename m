Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbUEBGW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUEBGW6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 02:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUEBGVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 02:21:53 -0400
Received: from mail.kroah.org ([65.200.24.183]:45965 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261605AbUEBGVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 02:21:44 -0400
Date: Sat, 1 May 2004 22:42:29 -0700
From: Greg KH <greg@kroah.com>
To: Fabian Fenaut <fabian.fenaut@free.fr>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: Sensors (W83627HF) in Tyan S2882
Message-ID: <20040502054229.GD31886@kroah.com>
References: <1082387882.4083edaa52780@imp.gcu.info> <200404191600.i3JG0ElX089970@zone3.gcu-squad.org> <20040419190133.351d1401.khali@linux-fr.org> <40840A18.8070907@free.fr> <20040419195034.24664469.khali@linux-fr.org> <4084192E.1040708@free.fr> <20040419204911.50cea556.khali@linux-fr.org> <40842F22.40009@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40842F22.40009@free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 09:57:22PM +0200, Fabian Fenaut wrote:
> Jean Delvare wrote:
> >>>Except that it doesn't apply, yes ;)
> >>>
> >>>I suspect that your email client is converting tabs to spaces.
> >>
> >>Sorry, see attachment.
> >
> >
> >I forgot to tell you... Patches are prefered in such a form that
> >patch -p1 from inside the linux directory works. Yours don't. I don't
> >think Greg will like it. That said, I don't think Greg likes patches
> >as attachements anyway ;)
> 
> 
> Ok, same player shoot again...

For some reason this patch doesn't apply at all.  Care to rediff against
the next -mm release and resend it to me?

thanks,

greg k-h

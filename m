Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264819AbUEEWUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbUEEWUt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 18:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264821AbUEEWUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 18:20:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:6065 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264819AbUEEWUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 18:20:47 -0400
Date: Wed, 5 May 2004 15:17:26 -0700
From: Greg KH <greg@kroah.com>
To: sensors@stimpy.netroedge.com
Cc: fabian.fenaut@free.fr, linux-kernel@vger.kernel.org
Subject: Re: Sensors (W83627HF) in Tyan S2882
Message-ID: <20040505221726.GB29885@kroah.com>
References: <1082387882.4083edaa52780@imp.gcu.info> <200404191600.i3JG0ElX089970@zone3.gcu-squad.org> <20040419190133.351d1401.khali@linux-fr.org> <40840A18.8070907@free.fr> <20040419195034.24664469.khali@linux-fr.org> <4084192E.1040708@free.fr> <20040419204911.50cea556.khali@linux-fr.org> <40842F22.40009@free.fr> <20040502054229.GD31886@kroah.com> <20040502140158.5fc16ca3.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040502140158.5fc16ca3.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 02:01:58PM +0200, Jean Delvare wrote:
> > For some reason this patch doesn't apply at all.  Care to rediff
> > against the next -mm release and resend it to me?
> 
> Actually the patch wasn't as perfect as I first thought, there were
> still indentation issues. I had to rework it a bit so that it would
> apply. Here is my modified version.

Applied, thanks.

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752648AbWAHRpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbWAHRpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 12:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbWAHRpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 12:45:25 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:6408 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1752648AbWAHRpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 12:45:25 -0500
Date: Sun, 8 Jan 2006 18:45:02 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ryan Anderson <ryan@michonline.com>
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] setlocalversion: Change -git_dirty to just -dirty
Message-ID: <20060108174502.GB10990@mars.ravnborg.org>
References: <20060104194203.GA2359@lsrfire.ath.cx> <20060106194735.GA15694@mars.ravnborg.org> <20060108093535.GA22585@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060108093535.GA22585@mythryan2.michonline.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 04:35:36AM -0500, Ryan Anderson wrote:
> 
> When building Debian packages directly from the git tree, the appended
> "git_dirty" is a problem due to the underscore.  In order to cause the
> least problems, change that just to "dirty".
> 
> Signed-off-by: Ryan Anderson <ryan@michonline.com>
Applied,

	Sam

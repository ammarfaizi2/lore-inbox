Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVGPIGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVGPIGo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 04:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVGPIGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 04:06:44 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:60758 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261198AbVGPIGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 04:06:43 -0400
Date: Sat, 16 Jul 2005 09:39:08 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Ryan Anderson <ryan@michonline.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Support UML and make O= when building Debian packages
Message-ID: <20050716093908.GA8064@mars.ravnborg.org>
References: <20050716055151.GH20369@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050716055151.GH20369@mythryan2.michonline.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2005 at 01:51:51AM -0400, Ryan Anderson wrote:
> Support UML builds and make O= when building Debian packages.
> 
> Sam, I'm pretty sure I've sent this before, but it seems to have been
> dropped. I've been using this for a while to build my personal kernels,
> and haven't had any problems.  This is a combination of old patches.

I have just recently got my setup functional again - and your old
patches has been included in my kbuild.git repository at kernel.org.
Andrew Morton sucks it into -mm and it should include your changes.
I plan to push upstream only when Linus has released his next kernel (not
-rc).
	Sam

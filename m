Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbUDLTtt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 15:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbUDLTtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 15:49:49 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:1885 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S263027AbUDLTtr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 15:49:47 -0400
Date: Mon, 12 Apr 2004 21:56:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Marcus Hartig <m.f.h@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm4
Message-ID: <20040412195636.GB12665@mars.ravnborg.org>
Mail-Followup-To: Marcus Hartig <m.f.h@web.de>,
	linux-kernel@vger.kernel.org
References: <407AEBB0.1050305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407AEBB0.1050305@web.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 09:19:12PM +0200, Marcus Hartig wrote:
> Hello,
> 
> patch: "kbuild-external-module-support" ?
> 
> brakes nicely my nVidia driver for installation at stage 2. Happy easter 
> gift. No setting of KBUILD_EXTMOD or editing the install script helps, 
> nice job.
Please provide me with more info.
I gooled a bit after some NVIDIA src - but I stopped when I had
to accept some NVIDIA stuff.

The purpose is to provide good support for external modules.
If it breaks things I need to find out why - and see where to fix it.

I would not be suprised if NVIDIA (and wmware for that matter) takes some
assumptions which it should not. But I need to find out why it break,
and for that I need more information!

So please provide me with the following information:
1) Exact log when it goes wrong
2) Pointer to or copy of the relevant files

	Sam

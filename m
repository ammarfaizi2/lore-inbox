Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVA3W6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVA3W6Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVA3W6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:58:24 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:55619 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261823AbVA3W6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:58:16 -0500
Date: Sun, 30 Jan 2005 23:59:59 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild: shorthand ym2y, ym2m etc
Message-ID: <20050130225959.GB21649@mars.ravnborg.org>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20050130193733.GA8984@mars.ravnborg.org> <200501302341.35086.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501302341.35086.arnd@arndb.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 11:41:34PM +0100, Arnd Bergmann wrote:
> Both are already used in the kernel (see ipc/Makefile for an
> example of yx2x), so maybe the preferred style should be documented
> in CodingStyle.

Thanks for input

I will try to do something. But their home will be
Documentation/kbuild/makefiles.txt

	Sam

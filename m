Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbTIVUzk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTIVUzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:55:40 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:19469 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262345AbTIVUzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:55:39 -0400
Date: Mon, 22 Sep 2003 22:55:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: GOTO Masanori <gotom@debian.or.jp>
Cc: Sam Ravnborg <sam@ravnborg.org>, "Nathan T. Lynch" <ntl@pobox.com>,
       Linus Torvalds <torvalds@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: kbuild: Remove cscope.out during make mrproper
Message-ID: <20030922205527.GA1308@mars.ravnborg.org>
Mail-Followup-To: GOTO Masanori <gotom@debian.or.jp>,
	Sam Ravnborg <sam@ravnborg.org>, "Nathan T. Lynch" <ntl@pobox.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
References: <20030910191411.GA5517@mars.ravnborg.org> <20030910191824.GD5604@mars.ravnborg.org> <808yog20t7.wl@oris.opensource.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <808yog20t7.wl@oris.opensource.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 02:24:52AM +0900, GOTO Masanori wrote:
> This patch looks fine.  But it's also good idea to remove
> cscope.in.out, cscope.po.out (for inverted index: -q option).

Thanks, applied.

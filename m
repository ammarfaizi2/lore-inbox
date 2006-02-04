Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946349AbWBDIGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946349AbWBDIGo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 03:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946350AbWBDIGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 03:06:44 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:268 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1946349AbWBDIGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 03:06:44 -0500
Date: Sat, 4 Feb 2006 09:06:13 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Fr?d?ric L. W. Meunier" <2@pervalidus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: menuconfig: no colors in 2.6.12-rc2 ?
Message-ID: <20060204080613.GA8655@mars.ravnborg.org>
References: <Pine.LNX.4.64.0602031957070.4864@dyndns.pervalidus.net> <20060203222843.GA11973@mars.ravnborg.org> <964857280602031447l57df7c1epced4a6f14979ce30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <964857280602031447l57df7c1epced4a6f14979ce30@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 08:47:31PM -0200, Fr?d?ric L. W. Meunier wrote:
 
> > Try to rename ncursesw to ncurses in
> > scripts/kconfig/lxdialog/check-dialog.sh
> > to test if ncursesw is the culprint.
> 
> Yes, that worked. Is it a bug in ncursesw ? I'm using a recent one.

Yes, I assume so. Eithet that or something local on your setup.
I have reports from others where use of ncursesw gives them nice looking
ASCII symbols in text mode and colours.
I do not have ncursesw myself so no possibility to test.

	Sam


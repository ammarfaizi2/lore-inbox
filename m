Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269290AbUJVXjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269290AbUJVXjs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269251AbUJVXjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:39:06 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:6311 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S269293AbUJVXfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:35:50 -0400
Date: Fri, 22 Oct 2004 16:35:36 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Jan Kara <jack@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] Quota warnings somewhat broken
Message-ID: <20041022233536.GA25750@taniwha.stupidest.org>
References: <Pine.LNX.4.53.0410211807020.12823@yvahk01.tjqt.qr> <20041022093423.GC31932@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.58.0410220804040.2101@ppc970.osdl.org> <1098455105.19459.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098455105.19459.9.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 03:25:06PM +0100, Alan Cox wrote:

> Tradition I guess. It's what every other quota system does,
> including making annoying messes. In the new world order I guess it
> should be a netlink message out to dbus and the desktop ;)

it's pretty obnoxious as-is and ideally if people want to preserve
this it should be sysctl'able off or something

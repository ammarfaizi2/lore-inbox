Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263057AbVCJTSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbVCJTSU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 14:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbVCJTQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 14:16:47 -0500
Received: from cantor.suse.de ([195.135.220.2]:59570 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263050AbVCJTMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 14:12:37 -0500
Date: Thu, 10 Mar 2005 20:12:23 +0100
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "David S. Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: bk commits and dates
Message-ID: <20050310191223.GA30903@suse.de>
References: <1110422519.32556.159.camel@gaston> <20050309194744.6aef66b7.davem@davemloft.net> <1110433821.32524.176.camel@gaston> <422FE571.7010101@pobox.com> <1110463905.4026.11.camel@localhost.localdomain> <20050310181809.GX3098@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050310181809.GX3098@smtp.west.cox.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Mar 10, Tom Rini wrote:

> I've just been using sort by arrival as an imperfect, but still mostly

Just procmail the stuff, if bk cant do it.

	:0 f
	* ^X-my-mailinglist-tag: bk-commits-head.vger.kernel.org
	| formail -i "Date:	`env TZ=UTC date -R`"

This doesnt help for "out of order" arrival, but you get the idea about
"what happend yesterday".

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbVCJOMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVCJOMq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 09:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVCJOMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 09:12:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32666 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262616AbVCJOMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 09:12:43 -0500
Subject: Re: bk commits and dates
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "David S. Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <422FE571.7010101@pobox.com>
References: <1110422519.32556.159.camel@gaston>
	 <20050309194744.6aef66b7.davem@davemloft.net>
	 <1110433821.32524.176.camel@gaston>  <422FE571.7010101@pobox.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 07:11:45 -0700
Message-Id: <1110463905.4026.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.6 (2.1.6-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 01:13 -0500, Jeff Garzik wrote:
> Speaking strictly in terms of implementation, David Woodhouse's 
> bk-commits mailer scripts could probably easily be tweaked to -not- set 
> an explicit Date header on the outgoing emails.
> 
> It then becomes a matter of deciding whether this is a good idea or not :)

The original changeset date is also in the body of the mail anyway so it
wouldn't be lost if we changed this. I have no real preference either
way. Bear in mind that the Date: header you got would then be the time
my script ran, not the time it was actually committed. That may differ
by days, in some cases (thankfully not often).

-- 
dwmw2


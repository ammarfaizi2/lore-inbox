Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWBZPrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWBZPrX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 10:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWBZPrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 10:47:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18924 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751227AbWBZPrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 10:47:22 -0500
Subject: Re: [PATCH] Revert sky2 to 0.13a
From: Arjan van de Ven <arjan@infradead.org>
To: pomac@vapor.com
Cc: woho@woho.de, Stephen Hemminger <shemminger@osdl.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       Pavel Volkovitskiy <int@mtx.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1140966011.22812.2.camel@localhost>
References: <4400FC28.1060705@gmx.net>
	 <20060225180353.5908c955@localhost.localdomain>
	 <200602260957.04305.woho@woho.de>  <1140966011.22812.2.camel@localhost>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 16:47:11 +0100
Message-Id: <1140968831.2934.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 16:00 +0100, Ian Kumlien wrote:
> On Sun, 2006-02-26 at 09:57 +0100, Wolfgang Hoffmann wrote:
> > On Sunday 26 February 2006 03:03, Stephen Hemminger wrote:
> > > Instead of whining, try this.
> > 
> > I tried and still see the hang.
> 
> I'm at a record 12 hours with that patch.

shhh don't jinx it ;)


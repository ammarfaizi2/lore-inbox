Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752130AbWAEKsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbWAEKsl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 05:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbWAEKsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 05:48:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23226 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752130AbWAEKsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 05:48:40 -0500
Subject: Re: [PATCH] Debug shared irqs.
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060105021929.498f45ef.akpm@osdl.org>
References: <1135251766.3557.13.camel@pmac.infradead.org>
	 <20060105021929.498f45ef.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 11:48:34 +0100
Message-Id: <1136458115.2920.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 02:19 -0800, Andrew Morton wrote:

> 
> This is going to cause me a ton of grief.  How's about you put it in
> Fedora for a few weeks, get all the drivers debugged first ;)

well it's a config option for a reason :)
Also it's something driver writers now can turn on so that THEY can
debug their driver as well.... -mm or even mainline is better for that
than fedora.



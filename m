Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264399AbTEaTSI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 15:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264422AbTEaTSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 15:18:08 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:21771 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264399AbTEaTSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 15:18:07 -0400
Date: Sat, 31 May 2003 20:31:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: must-fix, version 6
Message-ID: <20030531203125.A4202@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <20030530235008$3775@gated-at.bofh.it> <20030531095009$09a0@gated-at.bofh.it> <200305311558.h4VFwpKc024058@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305311558.h4VFwpKc024058@post.webmailer.de>; from arnd@arndb.de on Sat, May 31, 2003 at 05:26:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 05:26:12PM +0200, Arnd Bergmann wrote:
> >> o new zfcp fibre channel driver
> >> 
> >>   PRI3
> 
> These three drivers are not fully ported to 2.5 as they are less
> important and we have no plan of submitting them for either 2.4
> or 2.[567]. The code is also too ugly to be accepted anyway, so you
> can drop them from the list. Vendors can pick up the source
> from out developerworks site, as always...

So instead of fixing the code you rely on vendors merging crap?
what a wonderful idea, let's hope RH, SuSE & co reject it...


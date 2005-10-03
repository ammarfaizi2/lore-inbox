Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVJCVGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVJCVGp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVJCVGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:06:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:31195 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932423AbVJCVGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:06:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Subject: Re: Am1771 wireless driver?
Date: Mon, 3 Oct 2005 23:07:51 +0200
User-Agent: KMail/1.7.2
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       jt@hpl.hp.com
References: <433FD0F4.9090501@dunaweb.hu> <20051002121235.GA6276@infradead.org> <433FD938.6040502@dunaweb.hu>
In-Reply-To: <433FD938.6040502@dunaweb.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200510032307.52092.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünndag 02 Oktober 2005 14:57, Zoltan Boszormenyi wrote:
> Christoph Hellwig írta:
> > If you really have the full source for it forward-porting shouldn't
> > be much of a problem.  
> > 
> http://www.emota.com.br/wireless/extra/Am1771.tar.bz2
> 
Unfortunately, this thing seems to be licensed for non-use only:

/* This software and any related documentation (the "Materials") are the
 * confidential proprietary information of AMD. Unless otherwise provided
 * in an agreement specifically licensing the Materials, the Materials are
 * provided in confidence and may not to be used, distributed, modified, or
 * reproduced in whole or in part by any means. */

Even if you got this under a real source license, you would probably
have a hard time understanding enough of the 12MB tarball to port it to 2.6.

	Arnd <><

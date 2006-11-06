Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423744AbWKFKQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423744AbWKFKQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423743AbWKFKQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:16:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24715 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1423742AbWKFKQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:16:51 -0500
Date: Mon, 6 Nov 2006 11:16:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Jonathan Lemon <jlemon@flugsvamp.com>, linux-kernel@vger.kernel.org
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061106101633.GE2978@elf.ucw.cz>
References: <20061103163012.GA84707@cave.trolltruffles.com> <20061105204741.GA1847@elf.ucw.cz> <20061106101329.GA16817@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106101329.GA16817@2ka.mipt.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-11-06 13:13:29, Evgeniy Polyakov wrote:
> On Sun, Nov 05, 2006 at 09:47:41PM +0100, Pavel Machek (pavel@ucw.cz) wrote:
> > It has been show in this thread that kevent is too different to kqueue
> > as is... but what are the advantages of kevent? Perhaps we should use
> > kqueue on Linux, too (even if it means one more rewrite for you...?)
> 
> Should we use *BSD VMM system when we have superiour Linux one?

Very different question; VMM system is not something that has userland
API.

Can you explain why kevent is better than kqueue?

> P.S. Do not drop Cc: list.

It was not me who dropped cc list.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

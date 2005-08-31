Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVHaI2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVHaI2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 04:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVHaI2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 04:28:35 -0400
Received: from mail.enyo.de ([212.9.189.167]:54733 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S932488AbVHaI2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 04:28:34 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: Atheros and rt2x00 driver
References: <6278d22205081711115b404a9b@mail.gmail.com>
	<20050818205821.GA30510@localhost.localdomain>
	<4304F80F.10302@pobox.com> <87ll2ibkuk.fsf@mid.deneb.enyo.de>
	<20050831081636.GA28280@oepkgtn.mshome.net>
Date: Wed, 31 Aug 2005 10:28:02 +0200
In-Reply-To: <20050831081636.GA28280@oepkgtn.mshome.net> (Mateusz Berezecki's
	message of "Wed, 31 Aug 2005 10:16:36 +0200")
Message-ID: <87hdd6a4tp.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mateusz Berezecki:

> Florian Weimer <fw@deneb.enyo.de> wrote:
> -> The FTC issues are shared by many (most?) wireless drivers.  The
> -> copyright/trade secret issues might be worked around by basing the
> -> work on the OpenBSD version of that driver (and someone is actually
> -> working on that).
>
>  the problem with openbsd version of the hal is that it is - sorry to
>  say that - fundamentally broken, at least it was last time I was
>  checking.

It's better than nothing, that is, it worked for us when we gave it a
try.  And it seems to be relatively unencumbered.

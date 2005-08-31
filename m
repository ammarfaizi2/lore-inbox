Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVHaH5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVHaH5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbVHaH5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:57:18 -0400
Received: from mail.enyo.de ([212.9.189.167]:10957 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S932478AbVHaH5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:57:17 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mateusz Berezecki <mateuszb@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>
Subject: Re: Atheros and rt2x00 driver
References: <6278d22205081711115b404a9b@mail.gmail.com>
	<20050818205821.GA30510@localhost.localdomain>
	<4304F80F.10302@pobox.com>
Date: Wed, 31 Aug 2005 09:56:35 +0200
In-Reply-To: <4304F80F.10302@pobox.com> (Jeff Garzik's message of "Thu, 18 Aug
	2005 17:05:19 -0400")
Message-ID: <87ll2ibkuk.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik:

> There is still the open question of whether this is legal enough to 
> include in the kernel :(

Are you referring to FTC issues, or potential copyright/trade secret
issues?

The FTC issues are shared by many (most?) wireless drivers.  The
copyright/trade secret issues might be worked around by basing the
work on the OpenBSD version of that driver (and someone is actually
working on that).

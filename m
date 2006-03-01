Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWCAWCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWCAWCS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWCAWCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:02:18 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:26763 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751297AbWCAWCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:02:17 -0500
Subject: Re: PATA: New patch (2.6.16rc5-ide2)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fabio Comolli <fabio.comolli@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b637ec0b0603011250w6db739a2nb5b9a5994e0916e9@mail.gmail.com>
References: <1141242515.23170.6.camel@localhost.localdomain>
	 <b637ec0b0603011250w6db739a2nb5b9a5994e0916e9@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Mar 2006 23:03:02 +0000
Message-Id: <1141254183.3859.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-03-01 at 21:50 +0100, Fabio Comolli wrote:
> This was the same behaviour I got with 2.6.16-rc4-ide1; it changed
> with 2.6.15-ide1 (I did not report it just because I did not notice it
> ...)
> 
> I think that UDMA/33 should be the correct behaviour. Am I right?

Yes

> By the way, do you know why I get this "PIO error" messages?

Not yet



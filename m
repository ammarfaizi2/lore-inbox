Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbVKCUzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVKCUzI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 15:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVKCUzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 15:55:08 -0500
Received: from khc.piap.pl ([195.187.100.11]:24324 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932565AbVKCUzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 15:55:07 -0500
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Parallel ATA with libata status with the patches I'm working on
References: <1131029686.18848.48.camel@localhost.localdomain>
	<20051103144830.GF28038@flint.arm.linux.org.uk>
	<58cb370e0511030702hb06a5f3qc2dfe465ee1d784c@mail.gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 03 Nov 2005 21:55:05 +0100
In-Reply-To: <58cb370e0511030702hb06a5f3qc2dfe465ee1d784c@mail.gmail.com> (Bartlomiej
 Zolnierkiewicz's message of "Thu, 3 Nov 2005 16:02:45 +0100")
Message-ID: <m3oe51zc2e.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> writes:

> IMO porting/rewriting host-drivers to libata now is just
> counter-productive waste of time...

That would only make sense if you consider all PATA obsolete/dead
(do you? I'm sometimes not sure).

I don't and (unable to use old IDE due to hot-plug issues) am thankful
for Alan's efforts.

Yes, I think it's similar to OSS-ALSA, WRT - you know, 6-months forward
notice etc :-)
-- 
Krzysztof Halasa

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbVKCW3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbVKCW3L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbVKCW3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:29:11 -0500
Received: from khc.piap.pl ([195.187.100.11]:25348 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750865AbVKCW3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:29:10 -0500
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Parallel ATA with libata status with the patches I'm working on
References: <1131029686.18848.48.camel@localhost.localdomain>
	<20051103144830.GF28038@flint.arm.linux.org.uk>
	<58cb370e0511030702hb06a5f3qc2dfe465ee1d784c@mail.gmail.com>
	<m3oe51zc2e.fsf@defiant.localdomain>
	<58cb370e0511031329h7532259y6d3624fbf2d93f88@mail.gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 03 Nov 2005 23:29:03 +0100
In-Reply-To: <58cb370e0511031329h7532259y6d3624fbf2d93f88@mail.gmail.com> (Bartlomiej
 Zolnierkiewicz's message of "Thu, 3 Nov 2005 22:29:07 +0100")
Message-ID: <m3br11z7ps.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> writes:

> Do you think that libata is currently so much better wrt to PATA
> hot-(un)plug support?

For me? Libata works. Old IDE driver doesn't work. To be honest, haven't
checked since switched to libata, this problem might be fixed now.
-- 
Krzysztof Halasa

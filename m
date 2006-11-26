Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935384AbWKZNGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935384AbWKZNGi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 08:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935382AbWKZNGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 08:06:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62859 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S935380AbWKZNGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 08:06:38 -0500
Subject: Re: [2.6 patch] remove the broken VIDEO_ZR36120 driver
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061125191510.GB3702@stusta.de>
References: <20061125191510.GB3702@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 26 Nov 2006 11:06:25 -0200
Message-Id: <1164546385.4045.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sáb, 2006-11-25 às 20:15 +0100, Adrian Bunk escreveu:
> The VIDEO_ZR36120 driver has:
> - already been marked as BROKEN in 2.6.0 three years ago and
> - is still marked as BROKEN.
> 
> Drivers that had been marked as BROKEN for such a long time seem to be 
> unlikely to be revived in the forseeable future.
> 
> But if anyone wants to ever revive this driver, the code is still 
> present in the older kernel releases.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Acked-by: Mauro Carvalho Chehab <mchehab@infradead.org>

Ok, applied at my -git. 

Cheers, 
Mauro.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934147AbWKTMpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934147AbWKTMpO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 07:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934145AbWKTMpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 07:45:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16826 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S934147AbWKTMpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 07:45:13 -0500
Subject: Re: [RFC: 2.6 patch] remove the broken VIDEO_ZR36120 driver
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061118000137.GT31879@stusta.de>
References: <20061118000137.GT31879@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 20 Nov 2006 10:44:17 -0200
Message-Id: <1164026657.3014.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sáb, 2006-11-18 às 01:01 +0100, Adrian Bunk escreveu:
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

Although some people said they would fix it, nothing happens. Better to
remove this.

Acked-by: Mauro Carvalho Chehab <mchehab@infradead.org>

Cheers, 
Mauro.


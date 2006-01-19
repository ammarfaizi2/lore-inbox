Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161156AbWASKl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156AbWASKl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 05:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161247AbWASKl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 05:41:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44211 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161156AbWASKl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 05:41:27 -0500
Subject: Re: [PATCH] Fix compile warning in bt8xx module
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200601152332.54168.dtor_core@ameritech.net>
References: <200601152332.54168.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 19 Jan 2006 08:41:01 -0200
Message-Id: <1137667261.5754.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

	Your patch conflicted with another one by Jean Delaware. 

	Please next time send dvb or v4l patches to me c/c to
video4linux-list@redhat.com and linux-dvb-maintainer@linuxtv.org

Cheers,
Mauro.

Em Dom, 2006-01-15 às 23:32 -0500, Dmitry Torokhov escreveu:
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/media/dvb/bt8xx/dvb-bt8xx.c |    4 +---
>  1 files changed, 1 insertion(+), 3 deletions(-)
> 
> Index: work/drivers/media/dvb/bt8xx/dvb-bt8xx.c



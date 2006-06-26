Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWFZMsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWFZMsP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 08:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWFZMsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 08:48:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39858 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751209AbWFZMsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 08:48:12 -0400
Subject: Re: [PATCH] quickcam messenger build fix
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, jayakumar.video@gmail.com
In-Reply-To: <20060626083155.GA29923@havoc.gtf.org>
References: <20060626083155.GA29923@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 26 Jun 2006 09:47:48 -0300
Message-Id: <1151326068.3687.2.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, jeff,

Thanks.

Em Seg, 2006-06-26 às 04:31 -0400, Jeff Garzik escreveu:
> Fix build by fixing obvious typo in #include.

In fact, it were not a typo, but a change at the header name that went
yesterday to master.

Anyway, Andrew had noticed and did the same fix. I just sent a request
to Linus to pull his patch, along with other fixes on multimedia
drivers.

Cheers, 
Mauro.


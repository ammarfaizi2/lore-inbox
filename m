Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWAFT2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWAFT2h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWAFT2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:28:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3787 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932499AbWAFT2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:28:36 -0500
Subject: Re: [2.6 patch] remove drivers/net/tulip/xircom_tulip_cb.c
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060106192123.GB12131@stusta.de>
References: <20060106192123.GB12131@stusta.de>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 20:28:33 +0100
Message-Id: <1136575714.2940.73.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-1.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.8 DISGUISE_PORN          BODY: Attempts to disguise porn words
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 20:21 +0100, Adrian Bunk wrote:
> This patch removes the obsolete drivers/net/tulip/xircom_tulip_cb.c 
> driver.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>


NACK... xircom_cb (while written by me and thus purrrrrfect, doesn't
work for everyone). This chip is so f*cked up that it may not even be
possible to get all the variants working with only 1 driver ;-(



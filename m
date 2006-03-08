Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWCHSrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWCHSrG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 13:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWCHSrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 13:47:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49890 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932358AbWCHSrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 13:47:04 -0500
Subject: Re: [RFC: -mm patch] drivers/media/video/msp3400-kthreads.c: make
	3 functions static
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       v4l-dvb-maintainer@linuxtv.org
In-Reply-To: <20060308090829.GB4006@stusta.de>
References: <20060308090829.GB4006@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 08 Mar 2006 15:46:05 -0300
Message-Id: <1141843565.7534.22.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

Em Qua, 2006-03-08 às 10:08 +0100, Adrian Bunk escreveu:
> This patch makes three needlessly global functions static.

Thanks. Applied on both Mercurial and git trees. 

Cheers, 
Mauro.


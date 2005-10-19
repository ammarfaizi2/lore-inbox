Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVJSMBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVJSMBr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVJSMBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:01:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20895 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750777AbVJSMBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:01:46 -0400
Subject: Re: tty line discipline
From: Arjan van de Ven <arjan@infradead.org>
To: Rabih ElMasri <rabih.elmasri@infineon.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <7418fe470510190455x3bb746cax365092504e77ba3c@mail.gmail.com>
References: <7418fe470510190455x3bb746cax365092504e77ba3c@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 14:01:42 +0200
Message-Id: <1129723302.2822.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 13:55 +0200, Rabih ElMasri wrote:
> hi,
> 
> I am trying to assign a new line discipline to ttyS0 from within the
> kernel-space.

why? You don't describe what you want to solve, only how you want to do
it... it might be entirely the wrong solution for a simple problem..


>  During the initialization of my module I do the
> following:

you forgot to attach the full source of your module or point to URL with
that. That is basically rule nr 1 when posting about problems with
out-of-kernel modules; how else are people supposed to help you?



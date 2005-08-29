Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVH2Iet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVH2Iet (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 04:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVH2Iet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 04:34:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33716 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750714AbVH2Ies (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 04:34:48 -0400
Subject: Re: Oops in 2.4.30-hf2
From: Arjan van de Ven <arjan@infradead.org>
To: Ake <Ake.Sandgren@hpc2n.umu.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050829082900.GB11312@hpc2n.umu.se>
References: <20050829082900.GB11312@hpc2n.umu.se>
Content-Type: text/plain
Date: Mon, 29 Aug 2005 10:34:36 +0200
Message-Id: <1125304476.3339.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

On Mon, 2005-08-29 at 10:29 +0200, Ake wrote:
> I got the following Oops.
> Known problem? Fix?
> The kernel is a plain 2.4.30-hf2

> EIP:    0010:[<f890e708>]    Tainted: PF

no it's not

it has at least some chunk in it that doesn't come from kernel.org or
hf2



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbVHQHGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVHQHGq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 03:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbVHQHGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 03:06:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51335 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750946AbVHQHGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 03:06:46 -0400
Subject: Re: insmod error: Invalid module format.
From: Arjan van de Ven <arjan@infradead.org>
To: Nikhil Dharashivkar <nikhildharashivkar@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17db6d3a050816235729eff2c0@mail.gmail.com>
References: <17db6d3a050816235729eff2c0@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 17 Aug 2005 09:06:34 +0200
Message-Id: <1124262394.3220.14.camel@laptopd505.fenrus.org>
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

On Wed, 2005-08-17 at 12:27 +0530, Nikhil Dharashivkar wrote:
> Hi all,
>      I have RH9 installed with  2.6.7-1 kernel. I am able to compile
> the module but , when i load this module using insmod i get an error
> "insmod: error inserting './simple.o': -1 Invalid module format"
> 
> Please, any one tell me what is this meant ?
> 

this means that you didn't read the documentation on how to build
modules for your 2.6.7 kernel.



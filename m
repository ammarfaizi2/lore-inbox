Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVAMNZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVAMNZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 08:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVAMNZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 08:25:40 -0500
Received: from canuck.infradead.org ([205.233.218.70]:23308 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261615AbVAMNZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 08:25:36 -0500
Subject: Re: Bandwidth management under linux
From: Arjan van de Ven <arjan@infradead.org>
To: Johan Jordaan <aapman@gmail.com>
Cc: linux-kernel@vger.kernel.org, lartc@mailman.ds9a.nl
In-Reply-To: <8105747b0501130502342acdca@mail.gmail.com>
References: <8105747b0501130502342acdca@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 14:25:28 +0100
Message-Id: <1105622729.6031.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 13:02 +0000, Johan Jordaan wrote:
> In my search to control bandwidth on my network I found 2 projects..
> 
> 1. TC
> 2. BWM Tools - http://freshmeat.net/projects/bwmtools/
> 
> This brings me to 2 questions...
> 
> Firstly, can TC control bandwidth in both directions? I read that it
> can only do 1 direction, which one I cant remember

google for "wondershaper" .... it'll be a great learning thing for you
and it can do bidirectional shaping



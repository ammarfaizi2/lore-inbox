Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVBUJeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVBUJeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 04:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVBUJeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 04:34:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1739 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261931AbVBUJeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 04:34:18 -0500
Subject: Re: driver compile Parse error with gcc-3.4.3
From: Arjan van de Ven <arjan@infradead.org>
To: Anil Kumar <anilsr@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d3a6bba0050220182542696933@mail.gmail.com>
References: <d3a6bba0050220182542696933@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 21 Feb 2005 10:34:12 +0100
Message-Id: <1108978452.6297.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-20 at 18:25 -0800, Anil Kumar wrote:
> Hi,
> 
> I am new to linux. I am trying to build one of my drivers for
> 2.6.9-5.EL, RHEL 4, I am getting compile parse errors as follows:
> error: parse error before '(' token

you forgot to attach your full driver source (or URL to that)


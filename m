Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbVJ2Job@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbVJ2Job (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 05:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbVJ2Job
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 05:44:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21479 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750908AbVJ2Joa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 05:44:30 -0400
Subject: Re: segmentation fault when accessing /proc/ioports
From: Arjan van de Ven <arjan@infradead.org>
To: Patrick Useldinger <uselpa@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b2992ee70510290209h26c1fd6ex92fd137cd2c9d747@mail.gmail.com>
References: <b2992ee70510290209h26c1fd6ex92fd137cd2c9d747@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 29 Oct 2005 11:44:18 +0200
Message-Id: <1130579058.2908.6.camel@laptopd505.fenrus.org>
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


> I have read on the kernel mailing lists that this is due to drivers
> not properly unloading, so I won't post an lsmod.

this makes no sense. A driver is not properly doing it's unloading.. to
find out which that is an lsmod is NEEDED .....
unless people on this list are clearvoyant nobody can help you
otherwise...


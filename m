Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVCYJtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVCYJtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 04:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVCYJtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 04:49:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30604 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261568AbVCYJtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 04:49:14 -0500
Subject: Re: 2.6.12-rc1-mm2: crash in drm_agp_init
From: Arjan van de Ven <arjan@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Airlie <airlied@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20050325085306.GA1366@elf.ucw.cz>
References: <20050325083035.GA1335@elf.ucw.cz>
	 <21d7e99705032500434957cd97@mail.gmail.com>
	 <20050325085306.GA1366@elf.ucw.cz>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 10:49:05 +0100
Message-Id: <1111744146.6312.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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

>  (Why does -mm2 kernel have
> tendency to appear within hour from me downloading -mm1? It happened
> two times now...)

you just need a faster internet link :)


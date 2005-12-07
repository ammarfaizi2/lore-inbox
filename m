Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751755AbVLGSzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbVLGSzc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbVLGSzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:55:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49043 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751755AbVLGSzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:55:31 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: Arjan van de Ven <arjan@infradead.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Rik van Riel <riel@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0512071041420.17648@shark.he.net>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <20051205121851.GC2838@holomorphy.com>
	 <20051206011844.GO28539@opteron.random>
	 <1133857767.2858.25.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.63.0512071337560.17172@cuia.boston.redhat.com>
	 <Pine.LNX.4.58.0512071041420.17648@shark.he.net>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 19:55:08 +0100
Message-Id: <1133981708.2869.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Such lists could tell us not only which devices work (are
> supported with open source drivers) but also which devices
> are not supported and hence may need attention.
> 
> There has been some discussion about OSDL attempting to do this.

the biggest pitfal by having this done by a commercial entity or an
entity with commercial funding is that there is a LOT of pressure to
call things with binary drivers also certified/working. 
It has to be an entity that can resist that pressure; if OSDL can,
great. But their funding is partially from sources that will try to put
that pressure on I suspect...
So I would almost rather have a separate "kicked off and supported by
OSDL" organisation with its own charter than have OSDL do it itself. I
can imagine OSDL feeling the same as well ...


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbVLHQOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVLHQOr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVLHQOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:14:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61143 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751213AbVLHQOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:14:46 -0500
Subject: Re: How to enable/disable security features on mmap() ?
From: Arjan van de Ven <arjan@infradead.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Emmanuel Fleury <emmanuel.fleury@labri.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0512081051250.13997@chaos.analogic.com>
References: <43983EBE.2080604@labri.fr>
	 <1134051272.2867.63.camel@laptopd505.fenrus.org>
	 <43984154.5050502@labri.fr>  <43984595.1090406@labri.fr>
	 <1134053349.2867.65.camel@laptopd505.fenrus.org> <4398493E.50508@labri.fr>
	 <Pine.LNX.4.61.0512081011020.32448@chaos.analogic.com>
	 <1134056272.2867.73.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0512081051250.13997@chaos.analogic.com>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 17:14:41 +0100
Message-Id: <1134058481.2867.85.camel@laptopd505.fenrus.org>
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


> 0xbfbb6d74	Stack
> 0xb7e97008	Heap
> 0x080495e8	_end[]
> 

there is still a HUGE gap there....



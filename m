Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVKKFar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVKKFar (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 00:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbVKKFar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 00:30:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38562 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932358AbVKKFaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 00:30:46 -0500
Subject: RE: Reading BIOS information from a kernel driver
From: Arjan van de Ven <arjan@infradead.org>
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
Cc: Steven Schveighoffer <StevenS@NetworkEngines.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <0EF82802ABAA22479BC1CE8E2F60E8C37BA443@scl-exch2k3.phoenix.com>
References: <0EF82802ABAA22479BC1CE8E2F60E8C37BA443@scl-exch2k3.phoenix.com>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 06:30:40 +0100
Message-Id: <1131687041.2833.5.camel@laptopd505.fenrus.org>
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


> 
> I think you are looking for phys_to_virt(0xffa00)

and ioremap




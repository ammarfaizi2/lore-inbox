Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVLZXYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVLZXYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 18:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVLZXYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 18:24:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51158 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751097AbVLZXYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 18:24:45 -0500
Subject: Re: Ho ho ho.. Linux 2.6.15-rc7
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Mark Knecht <markknecht@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5bdc1c8b0512261002n6167a78ewfc45a6d3a5078ac0@mail.gmail.com>
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org>
	 <5bdc1c8b0512261002n6167a78ewfc45a6d3a5078ac0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 26 Dec 2005 21:24:37 -0200
Message-Id: <1135639477.6781.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[200.140.80.101 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[200.140.80.101 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Seg, 2005-12-26 às 10:02 -0800, Mark Knecht escreveu:
> On 12/24/05, Linus Torvalds <torvalds@osdl.org> wrote:
> >>> Unpacking ivtv-0.4.0.tar.gz to /var/tmp/portage/ivtv-0.4.0-r2/work
	IVTV is not part of kernel. You should try instead ivtv-0.5 stuff
(there are several duplicated modules between kernel and ivtv-0.4 that
were removed on 0.5 as part of a strategy of having it included on some
newer kernel version - maybe 2.6.17 or 2.6.18).

Cheers,
Mauro


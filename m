Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVCZPTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVCZPTY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 10:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVCZPTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 10:19:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21674 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262116AbVCZPTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 10:19:22 -0500
Subject: Re: How's the nforce4 support in Linux?
From: Arjan van de Ven <arjan@infradead.org>
To: Chuck <chunkeey@web.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200503261701.08774.chunkeey@web.de>
References: <200503261701.08774.chunkeey@web.de>
Content-Type: text/plain
Date: Sat, 26 Mar 2005 16:19:18 +0100
Message-Id: <1111850358.8042.34.camel@laptopd505.fenrus.org>
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

`
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC 

BadCRC is 99% sure a cabling issue; either a bad/overheated cable or a
cable used at too high a speed for the cable.



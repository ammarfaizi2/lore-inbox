Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVK0VZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVK0VZS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 16:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVK0VZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 16:25:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39138 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751154AbVK0VZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 16:25:16 -0500
Subject: Re: net_device + pci_dev question
From: Arjan van de Ven <arjan@infradead.org>
To: Mateusz Berezecki <mateuszb@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <2510370984.20051127205827@gmail.com>
References: <2510370984.20051127205827@gmail.com>
Content-Type: text/plain
Date: Sun, 27 Nov 2005 22:25:13 +0100
Message-Id: <1133126713.2853.45.camel@laptopd505.fenrus.org>
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

On Sun, 2005-11-27 at 20:58 +0100, Mateusz Berezecki wrote:
> Hello List!
> 
> Having only net_device pointer is it possible to retrieve associated pci_dev
> pointer basing on this information only?

what do you need it for?

(and.. what if the nic isn't a pci one?)


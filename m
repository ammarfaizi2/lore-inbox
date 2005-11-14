Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVKNRpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVKNRpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 12:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVKNRpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 12:45:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47587 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751198AbVKNRpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 12:45:39 -0500
Subject: Re: [PATCH] Make usbdevice_fs.h (again) useable from userspace
From: Arjan van de Ven <arjan@infradead.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, akpm@osdl.org
In-Reply-To: <20051114173727.GL4773@sunbeam.de.gnumonks.org>
References: <20051114173727.GL4773@sunbeam.de.gnumonks.org>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 18:45:27 +0100
Message-Id: <1131990327.2821.44.camel@laptopd505.fenrus.org>
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

On Mon, 2005-11-14 at 18:37 +0100, Harald Welte wrote:
> Make usbdevice_fs.h (again) useable from userspace
> 
> If we have CONFIG_COMPAT enabled, then userspace programs using
> usbdevice_fs.h won't compile anymore.

how does the userspace application set CONFIG_COMPAT??



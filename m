Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbVLFMYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbVLFMYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbVLFMYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:24:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3203 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964973AbVLFMYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:24:07 -0500
Subject: Re: [PATCH 01/10] usb-serial: URB write locking macros.
From: Arjan van de Ven <arjan@infradead.org>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, ehabkost@mandriva.com
In-Reply-To: <20051206095722.45cf4a32.lcapitulino@mandriva.com.br>
References: <20051206095722.45cf4a32.lcapitulino@mandriva.com.br>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 13:24:03 +0100
Message-Id: <1133871843.4836.15.camel@laptopd505.fenrus.org>
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

On Tue, 2005-12-06 at 09:57 -0200, Luiz Fernando Capitulino wrote:
>  Introduces URB write locking macros.

ugh.. WHY ?




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVLMIFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVLMIFF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVLMIFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:05:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38801 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751331AbVLMIFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:05:04 -0500
Subject: Re: Can't build loadable module for 2.6.kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Carlos Munoz <carlos@kenati.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <439DD4F8.3040709@kenati.com>
References: <439DD4F8.3040709@kenati.com>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 09:05:01 +0100
Message-Id: <1134461101.2866.21.camel@laptopd505.fenrus.org>
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

On Mon, 2005-12-12 at 11:52 -0800, Carlos Munoz wrote:
> Hi all,
> 
> I hope this is the right forum for this question.
> 
> I'm trying to build a loadable module for a telephony card that includes 
> several files. Some of the files are source files (written by me) and 
> some are object files (provided by the chip vendor). I'm unable to link 
> the vendor object files with the target.

you might want to ask them for the source, lots easier that way as well.



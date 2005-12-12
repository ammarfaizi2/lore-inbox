Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbVLLHXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVLLHXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 02:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbVLLHXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 02:23:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16360 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751014AbVLLHXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 02:23:50 -0500
Subject: Re: Errors while booting the newly built 2.6.12 kernel??
From: Arjan van de Ven <arjan@infradead.org>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B1BDAFA@mail.esn.co.in>
References: <3AEC1E10243A314391FE9C01CD65429B1BDAFA@mail.esn.co.in>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 08:23:46 +0100
Message-Id: <1134372226.2874.0.camel@laptopd505.fenrus.org>
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

On Mon, 2005-12-12 at 12:44 +0530, Mukund JB. wrote:
> Dear Kernel Team,
> 
> I am facing a strange error after I compiled the Linux kernel-2.6.12(downloaded from kernel.org).
> Please see the errors I get when I try to boot the newly built 2.6.12 kernel.
> 
> I found lot of members in the groups discussing this and no definite solution is suggestion.

you forgot to make an initrd.



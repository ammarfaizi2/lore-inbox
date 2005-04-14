Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVDNUBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVDNUBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 16:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVDNUBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 16:01:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30089 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261485AbVDNUBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 16:01:16 -0400
Subject: Re: Kernel module_list
From: Arjan van de Ven <arjan@infradead.org>
To: Allison <fireflyblue@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17d798805041412536dcd9325@mail.gmail.com>
References: <17d798805041412536dcd9325@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 22:01:13 +0200
Message-Id: <1113508873.6293.84.camel@laptopd505.fenrus.org>
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

On Thu, 2005-04-14 at 19:53 +0000, Allison wrote:
> 
> I am trying to access the module list kernel data structure from a
> kernel module. If I gather correctly, module_list is the symbol that
> is the head pointer of this list.

can you explain what you want to do with this symbol ?




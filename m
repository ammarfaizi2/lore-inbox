Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVAMOyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVAMOyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 09:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVAMOya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 09:54:30 -0500
Received: from canuck.infradead.org ([205.233.218.70]:25617 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261641AbVAMOxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 09:53:42 -0500
Subject: Re: propolice support for linux
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050113140446.GA22381@infradead.org>
References: <20050113134620.GA14127@boetes.org>
	 <20050113140446.GA22381@infradead.org>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 15:53:35 +0100
Message-Id: <1105628016.6031.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> EXPORT_SYMBOL_NOVERS(__guard);

_NOVERS is dead btw


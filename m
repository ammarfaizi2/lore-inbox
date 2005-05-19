Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVESKkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVESKkW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 06:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVESKkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 06:40:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23183 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262213AbVESKjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 06:39:51 -0400
Subject: Re: 2.4 kernel threads
From: Arjan van de Ven <arjan@infradead.org>
To: linux <kernel@wired-net.gr>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <00e301c55c5c$eb83d7c0$0101010a@dioxide>
References: <20050518223303.GE1340@ca-server1.us.oracle.com>
	 <20050518234022.GA5112@stusta.de>
	 <20050519012658.GA27595@ca-server1.us.oracle.com>
	 <20050519094517.GD5112@stusta.de>  <00e301c55c5c$eb83d7c0$0101010a@dioxide>
Content-Type: text/plain
Date: Thu, 19 May 2005 12:39:45 +0200
Message-Id: <1116499185.6027.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
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

On Thu, 2005-05-19 at 13:24 +0300, linux wrote:
> While attempting to unload the kernel module which has created a kernel
> thread whoch runs perfectly i get this oops:

you failed to put in an URL to the sourcecode of your module.



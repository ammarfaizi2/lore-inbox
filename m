Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbVKHWF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbVKHWF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbVKHWF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:05:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3800 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030375AbVKHWF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:05:28 -0500
Subject: Re: Creating new System.map with modules symbol info
From: Arjan van de Ven <arjan@infradead.org>
To: Adayadil Thomas <adayadil.thomas@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <fb7befa20511081304sec70208l5d1a464e5af78f58@mail.gmail.com>
References: <fb7befa20511081304sec70208l5d1a464e5af78f58@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 23:05:18 +0100
Message-Id: <1131487518.2789.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 16:04 -0500, Adayadil Thomas wrote:
> Greetings.
> 
> The System map that was created when compiling kernel does'nt have the symbols
> of modules that are loaded later. How can I create a new System.map
> with the symbols of
> modules also.

maybe a silly question.. but why does it matter? Eg what tool uses this
info?



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269646AbTGVGXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 02:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269659AbTGVGXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 02:23:37 -0400
Received: from clix.aarnet.edu.au ([192.94.63.10]:13543 "EHLO
	clix.aarnet.edu.au") by vger.kernel.org with ESMTP id S269646AbTGVGXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 02:23:36 -0400
Message-ID: <3F1CDBEA.60109@aarnet.edu.au>
Date: Tue, 22 Jul 2003 16:08:34 +0930
From: Glen Turner <glen.turner@aarnet.edu.au>
Organization: Australian Academic and Research Network
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: yi <yi@ece.utexas.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: TCP congestion window
References: <3F1C6406.5040009@ece.utexas.edu> <20030722062644.GA18791@netppl.fi>
In-Reply-To: <20030722062644.GA18791@netppl.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MDSA: Yes
X-Spam-Score: -102.9 IN_REP_TO,TO_LOCALPART_EQ_REAL,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Pietikainen wrote:

> Also what you want already exists, so no need to modify the kernel,
> the TCP_INFO socket option (netinet/tcp.h should have the required
> definitions in recent glibc)

There's also the Web100 patches at http://www.web100.org/
which add full TCP instrumentation, complete with a nice
set of GUI diagnostic tools.


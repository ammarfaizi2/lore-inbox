Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUK3Hu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUK3Hu7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 02:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUK3Hu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 02:50:59 -0500
Received: from canuck.infradead.org ([205.233.218.70]:34066 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262006AbUK3Huy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 02:50:54 -0500
Subject: Re: [PATCH] RLIMIT_MEMLOCK accounting of shmctl() SHM_LOCK is
	broken
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041129234353.378586a9.akpm@osdl.org>
References: <200411292204.iATM4o4C005049@hera.kernel.org>
	 <1101800060.2640.21.camel@laptop.fenrus.org>
	 <20041129234353.378586a9.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1101801044.2640.31.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 30 Nov 2004 08:50:45 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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

On Mon, 2004-11-29 at 23:43 -0800, Andrew Morton wrote:

> (I get the feeling that I'm missing your point here)

it's more that I'm missing my own point due to lack of caffeine at 9am

-- 


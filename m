Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVEBKzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVEBKzC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 06:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVEBKzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 06:55:02 -0400
Received: from s-utl01-nypop.stsn.com ([199.106.90.52]:22904 "HELO
	s-utl01-nypop.stsn.com") by vger.kernel.org with SMTP
	id S261163AbVEBKy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 06:54:59 -0400
Subject: Re: [2.6 patch] __deprecated_for_modules insert_resource
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050502014558.GH3592@stusta.de>
References: <20050415151043.GJ5456@stusta.de>
	 <20050423164411.51d77bf1.akpm@osdl.org>  <20050502014558.GH3592@stusta.de>
Content-Type: text/plain
Date: Mon, 02 May 2005 06:54:08 -0400
Message-Id: <1115031248.6434.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> --- linux-2.6.12-rc3-mm2-full/Documentation/feature-removal-schedule.txt.old	2005-05-01 23:59:05.000000000 +0200
> +++ linux-2.6.12-rc3-mm2-full/Documentation/feature-removal-schedule.txt	2005-05-02 00:00:17.000000000 +0200
> @@ -57,0 +58,8 @@
> +
> +---------------------------
> +
> +What:	remove EXPORT_SYMBOL(insert_resource)
> +When:	April 2006
> +Files:	kernel/resource.c

12 months is a really long time for something that's quite unlikely to
be used; how about 3 to 6 months?




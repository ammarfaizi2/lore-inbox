Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbVJZUZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVJZUZO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 16:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVJZUZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 16:25:14 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49330 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964868AbVJZUZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 16:25:12 -0400
Subject: Re: "Badness in local_bh_enable" - a reasonable fix?
From: Lee Revell <rlrevell@joe-job.com>
To: Steve Snyder <R00020C@freescale.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200510261601.19369.R00020C@freescale.com>
References: <200510261534.38291.R00020C@freescale.com>
	 <1130355615.3339.10.camel@laptopd505.fenrus.org>
	 <200510261601.19369.R00020C@freescale.com>
Content-Type: text/plain
Date: Wed, 26 Oct 2005 16:24:01 -0400
Message-Id: <1130358242.4483.127.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 16:01 -0400, Steve Snyder wrote:
> What, you mean the driver?  No, it is built from source against the
> installed & running Fedora Core 3 kernel version 2.6.12-1.1380_FC3. 

No, your kernel is tainted because you loaded some otehr proprietary
module.  Maybe nvidia?

Lee


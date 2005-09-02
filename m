Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVIBMOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVIBMOi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 08:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVIBMOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 08:14:37 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:61145 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751219AbVIBMOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 08:14:37 -0400
Subject: Re: 2.6.13-mm1: misc mwave issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050901232526.GF3657@stusta.de>
References: <20050901035542.1c621af6.akpm@osdl.org>
	 <20050901232526.GF3657@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Sep 2005 13:36:31 +0100
Message-Id: <1125664591.30867.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-09-02 at 01:25 +0200, Adrian Bunk wrote:
> The MWAVE also got a comment
>   # PLEASE DO NOT DO THIS - move this driver to drivers/serial

Mwave is an interested toy - its mostly an enabled for the hardware and
the services provided are not just serial but also audio etc


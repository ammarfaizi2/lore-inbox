Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbULPNxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbULPNxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 08:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbULPNxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 08:53:15 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:3202 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262663AbULPNxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 08:53:11 -0500
Subject: Re: USB making time drift [was Re: dynamic-hz]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: gene.heskett@verizon.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <200412152059.52292.gene.heskett@verizon.net>
References: <20041213002751.GP16322@dualathlon.random>
	 <200412151144.38785.gene.heskett@verizon.net>
	 <20041215182012.GH16322@dualathlon.random>
	 <200412152059.52292.gene.heskett@verizon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103201437.3804.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 12:50:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-16 at 01:59, Gene Heskett wrote:
> Unforch, I was not able to find that in the .config file, so where is
> that particular option set?

Base 2.6.9 hardcodes it, 2.6.9-ac has it in the configuration for x86


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVLLWwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVLLWwH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 17:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVLLWwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 17:52:07 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:16300 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932156AbVLLWwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 17:52:05 -0500
Subject: Re: 2.6.15-rc5-mm2: two cs5535 modules
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ben Gardner <gardner.ben@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <808c8e9d0512121029p4215d8b9y411a76d54f625677@mail.gmail.com>
References: <20051211041308.7bb19454.akpm@osdl.org>
	 <20051211175612.GL23349@stusta.de>
	 <808c8e9d0512121029p4215d8b9y411a76d54f625677@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Dec 2005 22:49:46 +0000
Message-Id: <1134427786.10304.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-12-12 at 12:29 -0600, Ben Gardner wrote:
> Hi Adrian,
> 
> Thanks for pointing that out. I'll use a different name.
> 
> Perhaps the cs5535 ide module should also be renamed to something more
> sane, like "cs5535-ide".

Historically all chipsets for IDE have been known by the chipset name.
Its already changed for the new sata layer. Its probably better to
rename the gpio type module, if indeed its even worth having in the
kernel (which I'm dubious about)


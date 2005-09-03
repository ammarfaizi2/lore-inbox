Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbVICR1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbVICR1y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 13:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVICR1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 13:27:54 -0400
Received: from [81.2.110.250] ([81.2.110.250]:33675 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750941AbVICR1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 13:27:53 -0400
Subject: Re: [-mm patch] FB_GEODE should depend on PCI
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: David Vrabel <dvrabel@arcom.com>, James Simmons <jsimmons@infradead.org>,
       "Antonino A. Daplas" <adaplas@pol.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <20050903120134.GL3657@stusta.de>
References: <20050903120134.GL3657@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 03 Sep 2005 18:49:31 +0100
Message-Id: <1125769771.14987.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-09-03 at 14:01 +0200, Adrian Bunk wrote:
> Due to fbdev-geode-updates.patch, building with CONFIG_PCI=n results in 
> the following error:

All the Geodes have PCI or internal PCI emulation so that change makes
sense.


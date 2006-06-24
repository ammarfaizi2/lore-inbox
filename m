Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWFXTlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWFXTlJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 15:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWFXTlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 15:41:09 -0400
Received: from mail.gmx.net ([213.165.64.21]:46267 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751066AbWFXTlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 15:41:08 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm2
Date: Sat, 24 Jun 2006 21:41:41 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060624061914.202fbfb5.akpm@osdl.org>
In-Reply-To: <20060624061914.202fbfb5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606242141.41055.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 24. June 2006 15:19, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1
>7/2.6.17-mm2/

hi!

I get this warning on make modules_install:

WARNING: /lib/modules/2.6.17-mm2/kernel/net/ieee80211/ieee80211.ko 
needs unknown symbol wireless_spy_update

regards,
dominik

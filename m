Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVCCPNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVCCPNh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 10:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVCCPNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 10:13:37 -0500
Received: from mail1.kontent.de ([81.88.34.36]:4797 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261211AbVCCPN1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 10:13:27 -0500
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [2.6 patch] remove drivers/usb/image/hpusbscsi.c
Date: Thu, 3 Mar 2005 16:13:36 +0100
User-Agent: KMail/1.7.1
Cc: Adrian Bunk <bunk@stusta.de>, gregkh@suse.de, linux-kernel@vger.kernel.org
References: <20050303133856.GT4608@stusta.de>
In-Reply-To: <20050303133856.GT4608@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503031613.36758.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 3. März 2005 14:38 schrieb Adrian Bunk:
> USB_HPUSBSCSI was marked as BROKEN in 2.6.11 since libsane is the 
> preferred way to access these devices.

That is true only if you limit yourself to users of SANE.
Other, rarer scan systems like VueScan use it. At least last time
somebody mentioned them. Do you have any hard evidence that
it is unused? 2.6.11 is out less than three days, which is not enough
for people to complain.

	Regards
		Oliver

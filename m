Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264858AbUDWPvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264858AbUDWPvV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 11:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264854AbUDWPvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 11:51:21 -0400
Received: from p15112047.pureserver.info ([217.160.169.118]:14250 "EHLO
	mail.wim-media.de") by vger.kernel.org with ESMTP id S264858AbUDWPvU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 11:51:20 -0400
From: Roessner Christian <info@roessner-net.com>
Organization: Roessner Network Solutions
To: linux-kernel@vger.kernel.org
Subject: Re: APIC probs with kernel 2.6.6-rc1-bk2 and usb, bttv
Date: Fri, 23 Apr 2004 17:51:26 +0200
User-Agent: KMail/1.6.2
References: <200404211926.05479.info@roessner-net.com>
In-Reply-To: <200404211926.05479.info@roessner-net.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404231751.29673.info@roessner-net.com>
X-Sagator-Scanner: clamd()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in the meantime I have tested kernel 2.6.6-rc2, but still no luck. I also 
played around with acpi_irq_nobalance and pci=noacpi, etc. But this does not 
fix it (Don´t know wht to do with flags, tagged as IA-32, because mine is a 
AMD64)

Maybe I forget something in my attached logfile: I use a Gigabyte K8N Pro with 
a NForce3 chipset.

Is there someone, who is interested in finding out, what is wrong? I would 
like to help fixing this, but I only could be a tester.

Thanks

Christian

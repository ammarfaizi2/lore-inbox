Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVADSSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVADSSv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 13:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVADSSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 13:18:51 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:13011 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261756AbVADSSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 13:18:48 -0500
Subject: Re: dmesg: PCI interrupts are no longer routed
	automatically.........
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: aryix <aryix@softhome.net>
Cc: lug-list@lugmen.org.ar, linux-kernel@vger.kernel.org
In-Reply-To: <20041229095559.5ebfc4d4@sophia>
References: <20041229095559.5ebfc4d4@sophia>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 11:18:41 -0700
Message-Id: <1104862721.1846.49.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have a device that doesn't work unless you specify
"pci=routeirq"?

If all your devices work, you can ignore the note in dmesg.


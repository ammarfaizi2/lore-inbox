Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbULLMrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbULLMrx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 07:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbULLMrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 07:47:53 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:9438 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262069AbULLMrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 07:47:48 -0500
Subject: Re: [PATCH] Re: PCI IRQ problems -- update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jim Paris <jim@jtan.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041211220307.GA23848@jim.sh>
References: <20041211173538.GA21216@jim.sh>
	 <1102783555.7267.37.camel@localhost.localdomain>
	 <20041211202314.GA22731@jim.sh>  <20041211220307.GA23848@jim.sh>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102851831.1371.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 12 Dec 2004 11:43:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-12-11 at 22:03, Jim Paris wrote:
> I added a quirk for this case.  This is against 2.6.10-rc3, and it
> makes all of my problems go away cleanly.  Is this reasonable?

I think so. You might want to send a copy to linux-ide@vger.kernel.org
so that Bartlomiej doesn't miss it.


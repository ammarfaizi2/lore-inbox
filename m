Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbUCIXs3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 18:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUCIXs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 18:48:28 -0500
Received: from linux-bt.org ([217.160.111.169]:33238 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S262285AbUCIXsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 18:48:23 -0500
Subject: Re: [Announce] Intel PRO/Wireless 2100 802.11b driver
From: Marcel Holtmann <marcel@holtmann.org>
To: James Ketrenos <jketreno@linux.co.intel.com>
Cc: arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <404E3EBB.7030803@linux.co.intel.com>
References: <404E27E6.40200@linux.co.intel.com>
	 <1078865831.4452.16.camel@laptop.fenrus.com>
	 <404E3EBB.7030803@linux.co.intel.com>
Content-Type: text/plain
Message-Id: <1078876080.10671.114.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Mar 2004 00:48:01 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> I was going down the path of using request_firmware but needed to support older 
> 2.4 kernels as well, so I punted for the time being and stuck with what you 
> currently see.

the request_firmware() is part of 2.4.23 and onwards. I have a backport
of it in my Bluetooth patches down to 2.4.18. Take a look at

	http://www.holtmann.org/linux/kernel/

Regards

Marcel



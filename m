Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUHILBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUHILBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 07:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUHILBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 07:01:35 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:43145 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S266477AbUHILBb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 07:01:31 -0400
Subject: Re: HCI USB on USB 2.0: hci_usb_intr_rx_submit (works with USB 1.1)
From: Marcel Holtmann <marcel@holtmann.org>
To: "Raf D'Halleweyn (list)" <list@noduck.net>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091581193.15561.3.camel@alto.dhalleweyn.com>
References: <1091581193.15561.3.camel@alto.dhalleweyn.com>
Content-Type: text/plain
Message-Id: <1092049263.21815.18.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 09 Aug 2004 13:01:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

> It seems that hci_usb does not like USB 2.0: when I connect a D-Link USB
> bluetooth dongle (DBT-120) to a USB 2.0 port, I get the following error
> message when I try to 'hciconfig hci0 up':
> 
> hci_usb_intr_rx_submit: hci0 intr rx submit failed urb f768ae94 err -28
> 
> If I connect the same dongle through a USB 1.1 hub on the same USB 2.0
> port, the device comes up and I don't get this error.

about what kernel version are you talking? What USB host hardware do you
use?

Regards

Marcel



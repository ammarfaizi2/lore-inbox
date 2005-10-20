Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751785AbVJTIC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbVJTIC1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 04:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbVJTIC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 04:02:27 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:33669 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751785AbVJTIC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 04:02:26 -0400
Subject: Re: USB-> bluetooth adapter problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Luke Albers <gtg940r@mail.gatech.edu>
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <4356DF14.7070804@mail.gatech.edu>
References: <43499A44.2070803@mail.gatech.edu>
	 <1128898123.19569.28.camel@blade>  <4356DF14.7070804@mail.gatech.edu>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 10:02:58 +0200
Message-Id: <1129795378.2241.29.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

> I got another one of these adapters, and when I plug the new one in I get:
> 
> usb 4-1: new full speed USB device using uhci_hcd and address 2
> Bluetooth: HCI USB driver ver 2.8
> usbcore: registered new driver hci_usb
> hcid[30219]: Bluetooth HCI daemon
> hcid[30219]: HCI dev 0 up
> hcid[30219]: Starting security manager 0
> 
> Then I remove that one and plug in the original and get the old problem:
> 
> usb 4-1: new full speed USB device using uhci_hcd and  address 3
> hcid[30219]: HCI dev 0 registered
> usb 4-1: USB disconnect, address 3
> hcid[1984]: Can't init device hci0: No such device (19 )
> hcid[30219]: HCI dev 0 unregistered
> 
> So the old one I was using seems to be a bad device, I just want to ask 
> if there are any other possibilities, other than bad hardware, before I 
> get rid of it.

I have no answer to this, but it looks like bad hardware. If you don't
wanna return it, you can send the adapter to me for some testing.

Regards

Marcel



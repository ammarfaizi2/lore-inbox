Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTDLBje (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 21:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbTDLBje (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 21:39:34 -0400
Received: from ivimey.org ([194.106.52.201]:14639 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id S262884AbTDLBjd (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 21:39:33 -0400
Subject: Re: USB Keyboard in 2.5 bitkeeper...
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
To: ivg2@cornell.edu
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200304111941.16563.ivg2@cornell.edu>
References: <200304111941.16563.ivg2@cornell.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1050112147.3778.5.camel@sharra.ivimey.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Apr 2003 02:49:07 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-04-12 at 00:41, Ivan Gyurdiev wrote:

> input1: USB HID v1.00 Keyboard [NOVATEK Keyboard NT6881] on usb1:3.0
> input2: USB HID v1.00 Mouse [NOVATEK Keyboard NT6881] on usb1:3.1
> 
> That's only a keyboard, but interestingly it shows up as a keyboard AND mouse.
> (This kernel is 2.4.21-pre5-ac3)

I have a USB keyboard (a BTC model 9000) that has a PS/2 mouse port on
the back. When USB enumerates it I get a keyboard controller and a mouse
controller connection... I guess that's the sort of thing you have.

Ruth


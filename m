Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVFHS34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVFHS34 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 14:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVFHS3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 14:29:55 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:17881 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261480AbVFHS14 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 14:27:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iwGaW4B47PTQjkL2nXhRf5vPyiSdTKtqPbyjBj/CGDuNXlq+QMqPR/yLXo5y/cRN7xpaVNHEJm3d8U8vYaCwTBhGPFVuaiohmKJhHwVV3vAsWSnkL2ms6QcnXjQnX9pCbb+MypjklXq+n+hP5CUdL7RHm1gqMr96pSTautx4UEo=
Message-ID: <c775eb9b0506081127406f241@mail.gmail.com>
Date: Wed, 8 Jun 2005 14:27:55 -0400
From: Bharath Ramesh <krosswindz@gmail.com>
Reply-To: Bharath Ramesh <krosswindz@gmail.com>
To: Duncan Sands <baldrick@free.fr>
Subject: Re: USB errors causes system to become unresponsive
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1118252287.8844.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c775eb9b0506081027d0cc6b9@mail.gmail.com>
	 <1118252287.8844.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/05, Duncan Sands <baldrick@free.fr> wrote:
> > I am running the 2.6 kernel and I notice that every now and then my
> > system stops responding but is still accessible remotely through ssh.
> > I can not work on the console. The only way out is to reboot either
> > remotely or by hitting the reset button. When the system comes up
> > again I get the following message in my dmesg and I need to actually
> > reboot it once or twice before this error goes. of I get a spew of
> > following messages. These messages don't stop till I reboot the
> > machine.
> >
> > drivers/usb/input/hid-core.c: input irq status -75 received
> 
> What usb devices do you have plugged in?
> 

I forgot to add that I am using Microsoft Wireless Desktop Keyboard
and Mice as the USB device. Sorry I forgot to mention that.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUHXFXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUHXFXk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 01:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266575AbUHXFXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 01:23:39 -0400
Received: from svr1.intas.net.au ([203.221.41.1]:40624 "EHLO svr1.intas.net.au")
	by vger.kernel.org with ESMTP id S266555AbUHXFXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 01:23:35 -0400
Date: Tue, 24 Aug 2004 15:26:11 +1000
Message-Id: <200408240526.i7O5QBOT025006@svr1.intas.net.au>
From: "Ben Skeggs" <d4rk74m4@intas.net.au>
To: linux-kernel@vger.kernel.org
Subject: HDD LED doesn't light.
X-Mailer: NeoMail 1.25
X-IPAddress: 147.109.250.25
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

No matter how much harddisk activity is occuring on my system, the 
harddisk LED stays off.  At first I thought I'd misconnected the lead, 
but under Windows the light is functional.

This occurs on both my SATA harddisk and my PATA harddisk.

SATA controller: Silicon Image sil3112
PATA controller: NForce2
Motherboard    : Abit NF7-S 2.0
CPU            : AthlonXP 3000+

The earliest kernel I've used with this hardware is 2.6.6, and the 
problem occurs right up to 2.6.8.1.

I'm completely clueless as I was under the impression that the hardware 
controlled the LED.

Could I please be CC'd any replies as I'm not subscribed to the list.

Regards,
Ben Skeggs

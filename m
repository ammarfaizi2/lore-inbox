Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSKRR4h>; Mon, 18 Nov 2002 12:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263281AbSKRR4h>; Mon, 18 Nov 2002 12:56:37 -0500
Received: from air-2.osdl.org ([65.172.181.6]:25235 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263246AbSKRR4g>;
	Mon, 18 Nov 2002 12:56:36 -0500
Date: Mon, 18 Nov 2002 10:02:27 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jochen Hein <jochen@jochen.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.48] Config.help misleading
In-Reply-To: <871y5iuajl.fsf@gswi1164.jochen.org>
Message-ID: <Pine.LNX.4.33L2.0211181001430.23971-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Jochen Hein wrote:

| Help says to say "Y" if unsure, but that isn't allowed:
| ,----
| |   UHCI HCD (most Intel and VIA) support (USB_UHCI_HCD) [N/m/?] (NEW) ?
| |
| | The Universal Host Controller Interface is a standard by Intel for
| | accessing the USB hardware in the PC (which is also called the USB
| | host controller). If your USB host controller conforms to this
| | standard, you may want to say Y, but see below. All recent boards
| | with Intel PCI chipsets (like intel 430TX, 440FX, 440LX, 440BX,
| | i810, i820) conform to this standard. Also all VIA PCI chipsets
| | (like VIA VP2, VP3, MVP3, Apollo Pro, Apollo Pro II or Apollo Pro
| | 133). If unsure, say Y.
| |
| | This code is also available as a module ( = code which can be
| | inserted in and removed from the running kernel whenever you want).
| | The module will be called uhci-hcd.o. If you want to compile it as a
| | module, say M here and read <file:Documentation/modules.txt>.
| |
| |   UHCI HCD (most Intel and VIA) support (USB_UHCI_HCD) [N/m/?] (NEW) y
| `----

Do you have proposed text or (even better) a patch for this?

-- 
~Randy
  "I read part of it all the way through." -- Samuel Goldwyn


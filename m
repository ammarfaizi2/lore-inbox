Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265719AbUBBRYp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 12:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265750AbUBBRYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 12:24:45 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:13062 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S265719AbUBBRYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 12:24:44 -0500
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: usb-uhci.c: iso_find_start: gap in seamless i sochronous scheduling
Date: Mon, 2 Feb 2004 18:24:25 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402021824.25734.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when I starts computer with USB BT dongle from Microsoft - Wireless 
Transceiver,

I got these messages:

cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff:<6>usb-uhci.c: iso_find_start: gap in seamless 
isochronous scheduling
usb-uhci.c: iso_find_start: gap in seamless isochronous scheduling
usb-uhci.c: iso_find_start: gap in seamless isochronous scheduling
usb-uhci.c: iso_find_start: gap in seamless isochronous scheduling
usb-uhci.c: iso_find_start: gap in seamless isochronous scheduling
usb-uhci.c: iso_find_start: gap in seamless isochronous scheduling
usb-uhci.c: iso_find_start: gap in seamless isochronous scheduling
usb-uhci.c: iso_find_start: gap in seamless isochronous scheduling
usb-uhci.c: iso_find_start: gap in seamless isochronous scheduling
usb-uhci.c: iso_find_start: gap in seamless isochronous scheduling
usb-uhci.c: iso_find_start: gap in seamless isochronous scheduling
 excluding<6>usb-uhci.c: iso_find_start: gap in seamless isochronous 
scheduling
 0x800-0x80f

I have ZCOM XI-325H in PCMCIA slot 

Thaks for help

Debian Woody 3.0 with bunk debs,
vanilla-2.4.24 kernel

Michal

